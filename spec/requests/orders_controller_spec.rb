require 'rails_helper'

RSpec.describe "OrdersController", type: :request do 
    let (:cart) {create(:cart)}
    let (:product) {create(:product)}
    let (:item) {create(:line_item)}
    let (:order) {create(:order)}
    before do                                                                    
        sign_in :user, create(:user)
    end

    describe "Get Checkout" do 
        it "successfully loads checkout page" do 
            
        end 
    end 
end 