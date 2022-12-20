require 'rails_helper'

RSpec.describe Order, type: :model do

  describe "model validations" do
    it "must have a related cart and user" do
      cart = create(:cart)
      user = create(:user)
      order = build(:order, cart_id: cart.id, user_id: user.id)
      expect(order).to be_valid
    end 
  end
end