require 'rails_helper'
#am I on the right track? should I seperate these out?
RSpec.describe "OrdersController", type: :request do 
    let (:cart) {create(:cart)}
    let (:product) {create(:product)}
    let (:item) {create(:line_item)}
    let (:order) {create(:order)}
    describe "Checkout Setup" do 
        before do 
            @user = create :user
            sign_in @user  
        end 
        it "signs in user" do 
            get profile_path(@user)
            expect(response).to be_successful
            expect(response.body).to include("Your Profile!")
            #expect(current_user).to eq(@user)
            #How do I 
        end

        it "assigns a cart to the session" do 
            #check if there is an active, valid cart to the session
            #check if it is connected to user
        end 

    end 
    describe "Get Checkout" do 
        it "successfully loads checkout page" do 
            #check if cart and order match up (line_items/order_items, totals)
            #check if all shipping info is entered correctly 
        end 

        it "successfully processes Stripe" do 
            #check if Stripe Params is ok 
            #check if Stripe request is accepted 
            #check if checkout was successful 
            #from (line 93) root_url + "success?session_id={CHECKOUT_SESSION_ID}",
            #expect(response.body).to contain("Thank you for your purchase!")
        end 
    end 
end 