class PublicController < ApplicationController
  def index
    @products = Product.all
    @array = []
    while @array.length < 4
      prod = @products.sample
      @array.push(prod)
    end
  end
end
