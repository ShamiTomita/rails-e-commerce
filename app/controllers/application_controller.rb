class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_cart
  before_action :set_stripe_key

  private
    def current_cart
      if session[:cart_id]
        cart = Cart.find_by(:id => session[:cart_id])
        if cart.present?
          @current_cart = cart
        else
          session[:cart_id] = nil
        end
      end

      if session[:cart_id] == nil
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end
    end

    def set_stripe_key
      Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
    end

    def create_products
      Product.all.each do |product|
        if !product.stripe_id
          price = product.price*100
          p = Stripe::Product.create(
          {
            name: product.name,
            default_price_data: {
              unit_amount: price.to_f.to_i,
              currency: 'usd',
            },
            images:[product.img],
            description: product.description,
            expand: ['default_price'],
          },
          )
          product.stripe_id = p.id
          product.save
        end
      end
    end

    def create_prices
      Product.all.each do |product|
        if product.stripe_id
          price = product.price*100
          Stripe::Price.create({
            unit_amount: price.to_f.to_i,
            currency: 'usd',
            product: product.stripe_id,
            })
        end
      end
    end
end
