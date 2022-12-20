require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  describe "model validations" do
    it "must have a related order, product, and line item" do
      order = create(:order)
      line_item = create(:line_item)
      product = create(:product)
      order_item = build(:order_item, order_id: order.id, line_item_id: line_item.id, product_id: product.id)
      expect(order_item).to be_valid
    end 
  end
end