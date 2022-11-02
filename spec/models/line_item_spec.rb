require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it "must have a related cart, user, and product" do
    cart = FactoryBot.build(:cart)
    user = FactoryBot.build(:user)
    product = FactoryBot.build(:product)
    line_item = FactoryBot.build(:line_item)
    expect(line_item.cart_id) != nil
    expect(line_item.user_id) != nil
    expect(line_item.product_id) != nil
  end
end
