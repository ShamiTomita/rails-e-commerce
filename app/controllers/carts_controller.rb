class CartsController < ApplicationController
  def show
    @cart = @current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.line_items.each do |item|
      item.destroy
    end
    redirect_to cart_path(@cart.id)
  end
end
