require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it "must have a related cart" do
    line_item = FactoryBot.create(:line_item)
    expect(line_item.cart_id) != nil
  end 
end
