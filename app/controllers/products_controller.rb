class ProductsController < ApplicationController
  def index
    session[:search_name] ||= params[:search_name]
    session[:filter] = params[:filter]
    params[:filter_option] = nil if params[:filter_option] == ""
    session[:filter_option] = params[:filter_option]
    #TODO refactor eventually
    #############
    if session[:filter_option] && session[:filter] == "water"
      if session[:filter_option] == "low"
        @products = Product.all.filter_by_water("drought")
      elsif session[:filter_option] == "med"
        @products = Product.all.filter_by_water("dry")
      elsif session[:filter_option] == "high"
        @products = Product.all.filter_by_water("thoroughly")
      end
    ############# 
    elsif session[:filter_option] && session[:filter] == "light"
      if session[:filter_option] == "low"
        @products = Product.all.filter_by_light("tolerates")
      elsif session[:filter_option] == "med"
        @products = Product.all.filter_by_light("indirect")
      elsif session[:filter_option] == "high"
        @products = Product.all.filter_by_light("bright")
      end
    ############  
    elsif session[:filter_option] && session[:filter] == "temp"
      if session[:filter_option] == "low"
        @products = Product.all.filter_by_temp("80")
      elsif session[:filter_option] == "med"
        @products = Product.all.filter_by_temp("85")
      elsif session[:filter_option] == "high"
        @products = Product.all.filter_by_temp("90")
      end 
    ############  
    elsif session[:filter] == "low_price"
      @products = Product.all.lowest_price
    elsif session[:filter] == "high_price"
      @products = Product.all.highest_price  
    else 
      @products = Product.all 
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

    def initialize_search
      @products = Product.all
      session[:search_name] ||= params[:search_name]
      session[:filter] = params[:filter]
      params[:filter_option] = nil if params[:filter_option] == ""
      session[:filter_option] = params[:filter_option]
    end

  def handle_search_name
    if session[:search_name]
      @products = Product.where("name LIKE ?", "%#{session[:search_name]}%")

    else
      @product = Product.all
    end
  end

  def handle_filters
    if session[:filter_option] && session[:filter] == "most_recent"
      @forums = Forums.most_recent
    elsif session[:filter_option] && session[:filter] == "category"
      @forums = Forum.where(category: session[:filter_option])
    elsif session[:filter_option] && session[:filter] == "by_popularity"
      @forums = Forum.by_popularity
    elsif session[:filter_option] && session[:filter] == "active"
      @forums = Forums.active
    end
  end

end
