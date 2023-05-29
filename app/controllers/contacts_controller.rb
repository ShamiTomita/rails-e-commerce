class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = User.find_by(email: contact_params[:email])&.id

    if params[:product_name].length > 0
      p = Product.all.find {|prod| prod.name.downcase.include?(params[:product_name].downcase) }
      @contact.product_id = p.id
    end 

    if params[:order_number].length > 0 
      o = Order.find_by_id(params[:order_number])
      @contact.order_id = o&.id
    end

    if @contact.save
      redirect_to root_path, notice: "Thank you for your message!"
    else
      render :new
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :issue_type, :message, :product_name, :order_number, :account,)
  end

end
