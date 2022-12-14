class LineItemsController < ApplicationController
  def create
    # Find associated product and current cart
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart
    # If cart already has this product then find the relevant line_item and iterate quantity otherwise create a new line_item for this product
    if current_cart.products.include?(chosen_product)
      # Find the line_item with the chosen_product
      @line_item = current_cart.line_items.find_by(:product_id => chosen_product)
      # Iterate the line_item's quantity by one
      update(@line_item)
    else
      @line_item = LineItem.new(user_id:current_user.id, cart_id:current_cart.id, product_id:chosen_product.id, quantity:1)
      # Save and redirect to cart show path
      respond_to do |format|
        if @line_item.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.append("cart", partial: "line_items/line_item", locals: {line_item: @line_item}),
              turbo_stream.update('notice', "Added Item!"),
              turbo_stream.update("cart_total", html: "Your Total: #{@current_cart.sub_total}")]
          end
        end
      end
    end
  end


  def destroy
    @line_item = LineItem.find(params[:id])
    if @line_item.order_item
      ######################################################################
      @order_item = @line_item.order_item
      @order_item.destroy
      @line_item.destroy
      @order = @line_item.order_item.order
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove(@line_item),
            turbo_stream.remove(@order_item),
            turbo_stream.update("finalized",
                                 partial: "orders/confirm",
                                locals: {order: @order}),
            turbo_stream.update("finalized-order",
                                html: "Order Total: #{@current_cart.sub_total}"),
            turbo_stream.update("cart_total",
                                html: "Your Total: #{@current_cart.sub_total}"),
            turbo_stream.update("order_total",
                                html: "Your Total: #{@current_cart.sub_total}")
                              ]
        end
      end
      ######################################################################
    else #if there is no corresponding order_item
      @line_item.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove(@line_item),
            turbo_stream.update("cart_total",
                                html: "Your Total: #{@current_cart.sub_total}")
                              ]
        end
      end
    end
  end

  def add_quantity
    @line_item = LineItem.find(params[:id])
    #@order_item = @current_cart.order.order_items.find_by(product_id: @line_item.product.id)
    @line_item.quantity += 1
    respond_to do |format|
      if @line_item.update(quantity: @line_item.quantity)
        if @line_item.order_item
          ######################################################################
          @order = @line_item.order_item.order
          @line_item.order_item.update(quantity: @line_item.quantity)
          format.turbo_stream do
            render turbo_stream:[
              turbo_stream.update(@line_item,
                                  partial: "line_items/line_item",
                                  locals: {line_item: @line_item}),
             turbo_stream.update(@line_item.order_item,
                                  partial: "order_items/order_item",
                                 locals: {order_item: @line_item.order_item}),
             turbo_stream.update("finalized",
                                  partial: "orders/confirm",
                                 locals: {order: @order}),
             turbo_stream.update("finalized-order",
                                 html: "Order Total: #{@current_cart.sub_total}"),
              turbo_stream.update("cart_total",
                                  html: "Your Total: #{@current_cart.sub_total}"),
              turbo_stream.update("order_total",
                                  html: "Your Total: #{@current_cart.sub_total}")
                                ]
          end
          ######################################################################
        else #if there is no corresponding order_item
        format.turbo_stream do
          render turbo_stream:[
            turbo_stream.update(@line_item,
                                partial: "line_items/line_item",
                                locals: {line_item: @line_item}),
            turbo_stream.update("cart_total",
                                html: "Your Total: #{@current_cart.sub_total}"),
            turbo_stream.update("order_total",
                                html: "Your Total: #{@current_cart.sub_total}")
                              ]
          end
        end
      end
    end
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    respond_to do |format|
      if @line_item.update(quantity: @line_item.quantity)
        if @line_item.order_item
          ######################################################################
          @line_item.order_item.update(quantity: @line_item.quantity)
          @order = @line_item.order_item.order
          format.turbo_stream do
            render turbo_stream:[
              turbo_stream.update(@line_item,
                                  partial: "line_items/line_item",
                                  locals: {line_item: @line_item}),
              turbo_stream.update("finalized",
                                   partial: "orders/confirm",
                                  locals: {order: @order}),
              turbo_stream.update("finalized-order",
                                  html: "Order Total: #{@current_cart.sub_total}"),
              turbo_stream.update(@line_item.order_item,
                                  partial: "order_items/order_item",
                                  locals: {order_item: @line_item.order_item}),
              turbo_stream.update("cart_total",
                                  html: "Your Total: #{@current_cart.sub_total}"),
              turbo_stream.update("order_total",
                                  html: "Your Total: #{@current_cart.sub_total}")]
          end
          ######################################################################
        else #if there is no corresponding order_item
        format.turbo_stream do
          render turbo_stream:[
            turbo_stream.update(@line_item,
                                partial: "line_items/line_item",
                                locals: {line_item: @line_item}),
            turbo_stream.update("cart_total",
                                html: "Your Total: #{@current_cart.sub_total}"),
            turbo_stream.update("order_total",
                                html: "Your Total: #{@current_cart.sub_total}")]
          end
        end
      end
    end
  end


  def update(line_item)
    line_item.quantity += 1
    respond_to do |format|
      if line_item.update(quantity:line_item.quantity)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(line_item,
                                partial: "line_items/line_item",
                                locals: {line_item: line_item}),
            turbo_stream.update("cart_total",
                                html: "Your Total: #{@current_cart.sub_total}"),
            turbo_stream.update("order_total",
                                html: "Your Total: #{@current_cart.sub_total}")]
        end
      end
    end
  end



  private
    def line_item_params
      params.require(:line_item).permit(:quantity,:product_id, :cart_id, :user_id)
    end
end
