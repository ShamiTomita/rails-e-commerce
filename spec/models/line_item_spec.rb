require 'rails_helper'

RSpec.describe LineItem, type: :model do

  describe "model validations" do
    it "must have a related cart, product, and user" do
      cart = create(:cart)
      user = create(:user)
      product = create(:product)
      line_item = build(:line_item, cart_id: cart.id, user_id: user.id, product_id: product.id)
      expect(line_item).to be_valid
    end 
  end

  describe "total price" do 
    it "correctly calculates the total price of the line_item" do 
      product = create(:product, price:1.00)
      line_item = build(:line_item, product_id:product.id, quantity:2)
      expect(line_item.total_price).to eq(2.00)
    end 
  end 
end
