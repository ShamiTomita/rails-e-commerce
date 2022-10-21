class OrdersController < ApplicationController

  def checkout
    @order = Order.find(params[:id])
  end

  def confrim
    @order = Order.find(params[:id])
  end

  def finalized
    @order = Order.find(params[:id])
    @order.status = 1
    @order.save
    @current_cart.line_items.each do |item|
      item.destroy
    end
    @current_cart.destroy
    redirect_to order_url(@order)
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

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to order_url(@order)
  end


private
  def order_params
    params.require(:order).permit(:name, :shipping_address, :email, :payment_method, :total)
  end
end
