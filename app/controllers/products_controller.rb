class ProductsController < ApplicationController
  def index
    @products = Product.all
    session[:filter] = params[:filter]
    if session[:filter] == "low"
      @products.filter_by_water("drought")
    elsif session[:filter] == "med"
      @products.filter_by_water("dry")
    elsif session[:filter] == "high"
      
      @products.filter_by_water("thoroughly")
    end 
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def show
    @product = Product.find(params[:id])
  end
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to products_path
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private
    def product_params
      params.require(:product).permit(:name, :price)
    end

end
