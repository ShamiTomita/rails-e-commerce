class OrdersController < ApplicationController

  def finalized(order)
    order.total = @current_cart.sub_total
    order.status = 1
    order.save
    @current_cart.destroy
  end


  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @user = current_user
    if @order.order_items.empty?
      redirect_to products_path
    end
  end

  def new
    @order = Order.new
  end

  def create
    #check if an order for this cart has been created
    if !@current_cart.order
      @order = Order.create!(user_id: current_user.id, cart_id: @current_cart.id)
    else
      @order = @current_cart.order
    end
    if !!@order
      @current_cart.line_items.each do |item|
            order_item = @order.order_items.find_by(:product_id => item.product.id)
          if !!order_item
            order_item.update(quantity: item.quantity)
          else
            @order.order_items.create!(
              line_item_id: item.id,
              product_id: item.product_id,
              quantity: item.quantity
              )
          end
        end
      redirect_to order_path(@order)
    end
  end

  def update #target here
    @order = Order.find(params[:id])
    @order.update(order_params)
    if !@order.order_items.empty?
      stripe_checkout(@order)
    else
      redirect_to products_path
    end
  end

  def stripe_checkout(order)
    if !current_user.stripe_id
      @customer = Stripe::Customer.create(email:order.email)
      current_user.stripe_id = @customer.id
      current_user.save
    end
    items = order.order_items.map{|item| {
      price: Stripe::Product.retrieve(item.product.stripe_id).default_price,
      quantity: item.quantity
      }}
    @session = Stripe::Checkout::Session.create({
       customer: current_user.stripe_id,
       payment_method_types: ['card'],
       line_items: [items],
       mode: 'payment',
       success_url: root_url + "success?session_id={CHECKOUT_SESSION_ID}",
       cancel_url: root_url,
     })
     finalized(order)
     redirect_to @session.url, allow_other_host: true
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @customer = Stripe::Customer.retrieve(session.customer)
  end


private
  def order_params
    params.require(:order).permit(:first_name, :last_name, :street_address, :email, :payment_method, :total, :zipcode, :city, :state)
  end
end
