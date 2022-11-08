class OrdersController < ApplicationController

  def checkout
    @order = Order.find(params[:id])
    @user = current_user
    if @order.order_items.empty?
      redirect_to products_path
    end
  end

  def confrim
    @order = Order.find(params[:id])
    redirect_to root_path
  end

  def finalized
    @order = Order.find(params[:id])
    @order.total = @current_cart.sub_total
    @order.status = 1
    @order.save
    @current_cart.line_items.each do |item|
      item.destroy
    end
    @current_cart.destroy
    redirect_to "/profile"
  end

  def shipping
    @user = @current_user
    @order = Order.find(params[:id])
  end

  def checkout_item
    @item = LineItem.find(params[:id])
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
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
      redirect_to checkout_path(@order)
    end
  end

  def update #target here
    @order = Order.find(params[:id])
    @order.update(order_params)
    if !@order.order_items.empty?
      stripe_checkout(@order)
      redirect_to order_url(@order)
    else
      redirect_to products_path
    end
  end

  def stripe_checkout(order)
    @session = Stripe::Checkout::Session.create({
       customer: current_user.id,
       payment_method_types: ['card'],
       line_items: order.order_items,
       allow_promotion_codes: true,
       mode: 'payment',
       success_url: ordered_path(order) + "?session_id={CHECKOUT_SESSION_ID}",
       cancel_url: root_path,
     })
     redirect_to @session.url
  end


private
  def order_params
    params.require(:order).permit(:first_name, :last_name, :street_address, :email, :payment_method, :total, :zipcode, :city, :state)
  end
end
