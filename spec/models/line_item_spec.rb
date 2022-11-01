require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it "must have a related cart" do
    cart = FactoryBot.create(:cart)
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    line_item = FactoryBot.create(:line_item)
    expect(line_item.cart_id) != nil
    expect(line_item.user_id) != nil
    expect(line_item.product_id) != nil
  end
end
