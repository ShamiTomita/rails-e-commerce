class OrdersController < ApplicationController

  def checkout
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
    if !@current_cart.order
      @order = Order.create(user_id: current_user.id, cart_id: @current_cart.id)
      if @order.save
        @current_cart.line_items.each do |item|
          @order.order_items.create!(
            product_id: item.product_id,
            quantity: item.quantity
            )
        end
      end
      redirect_to checkout_path(@order.id)
    else
      @order = @current_cart.order
      redirect_to checkout_path(@order.id)
    end
  end

private
  def order_params

  end
end
