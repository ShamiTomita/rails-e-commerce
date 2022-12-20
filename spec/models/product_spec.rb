require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "model validations" do 
        it "requires a name" do 
            plant = build(:product, name: "")
            expect(plant.valid?).to be false 
        end
        it "requires a price" do 
            plant = build(:product, price:"")
            expect(plant.valid?).to be false 
        end  
    end 
end
