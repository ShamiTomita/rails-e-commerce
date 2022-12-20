require 'rails_helper'

RSpec.describe Cart, type: :model do
  it "correctly adds the sum of all its line items" do 
    product1 = create(:product, price:5.00)
    item1 = create(:line_item, product_id:product1.id, quantity: 2)
    
    product2 = create(:product, price:10.00)
    item2 = create(:line_item, product_id:product2.id, quantity:1)

    cart = create(:cart)
    cart.line_items.push(item1, item2)

    expect(cart.sub_total).to eq(20.00)
  end 

end
