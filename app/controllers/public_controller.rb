class PublicController < ApplicationController
  def index
    @products = Product.all
  end
end
