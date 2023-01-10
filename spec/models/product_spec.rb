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

    describe "scopes" do 
        #makes sure the scope is working properly, not that its showing up... not the right test!
    end 
end
