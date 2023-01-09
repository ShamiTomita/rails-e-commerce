class AdminController < ApplicationController
  def index
    @products = Product.all
    @customers = User.all.select {|user| user.role == "user"}
    @orders = Order.all
  end

  def products
  end

  def orders
  end

  def users
  end
end
