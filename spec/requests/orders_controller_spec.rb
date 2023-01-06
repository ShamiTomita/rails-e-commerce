require 'rails_helper'
require 'stripe_mock'
#am I on the right track? should I seperate these out?
#Checkout Placing an order
#test doubles 

RSpec.describe "OrdersController", type: :request do 
    let (:cart) {create(:cart)}
    let (:product) {create(:product)}
    let (:item) {create(:line_item)}
    let (:order) {create(:order)}

    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    describe "Checkout Setup" do 
        before do 
            @user = create :user
            sign_in @user  
        end 
        #signed in user can add items
        #make tests more independent
        it "signs in user" do #Step 0
            get profile_path(@user)
            expect(response).to be_successful
            expect(response.body).to include("Your Profile!")
            #How do I 
        end
        #add more detail if its the main product 
        #bulletted list 

        it "assigns a cart to the session" do 
            pending("getting to it")
            #check if there is an active, valid cart to the session
            #check if it is connected to user
        end 

        it "allows for adding items to cart" do 
            pending("getting to it")
        end 

    end 
    describe "Get Checkout" do 
        before do 
            @user = create :user
            sign_in @user  
        end 
        it "successfully loads checkout page" do 
            pending("getting to it")
            #check if cart and order match up (line_items/order_items, totals)
            #check if all shipping info is entered correctly 
        end 

       
            
            #check if Stripe Params is ok 
            #check if Stripe request is accepted 
            #allow(Stripe::Checkout:).to receive(:checkout).with(params).and_return(success)

            #Stripe::Checkout::Session.create({
            #    customer: current_user.stripe_id,
            #    payment_method_types: ['card'],
            #    line_items: [items], #make sure these items are ready
            #    mode: 'payment',
                #success_url: root_url + "success?session_id={CHECKOUT_SESSION_ID}",
                #cancel_url: root_url,
            #})

            #mocks/stubs -> stand in object 
            #stripe encapsulted within test to be tested
            #check if checkout was successful 
            #from (line 93) root_url + "success?session_id={CHECKOUT_SESSION_ID}",
            #expect(response.body).to contain("Thank you for your purchase!")

            #mock ecommerce for stripe? libraries have testing->stripe 
      
        it "performs a stripe checkout" do
            #locate current_user 
            #locate current_cart 
            #create order-> order should have the info to be used in this stripe checkout 
            #post request to orders checkout

            #introducing new library, but have own wrapper around it
            
            prod =  Product.all.first
            stripe_product = {price: Stripe::Product.retrieve("1").default_price, quantity:1}
            
            allow(Stripe::Checkout::Session).to receive(:create)
            order = create(:order, user_id: @user.id, cart_id: cart.id) #add order params)
            
            order.order_items << order_item 
            
            #create fake order
            put order_path(order), params: { order: {first_name: "1", last_name: "1", street_address: "1", email: "1@gmail.com", payment_method: "1", total: 1.00, zipcode: "1", city: "1", state: "1"}}
            #make call to stripe sandbox
            
            #SEND REQUEST TO APP->post is doing the same thing as below
            #Stripe::Checkout::Session.create({
            #customer: "1234",
            #payment_method_types: ['card'],
            #line_items: [{}],
            #mode: 'payment',
            #})
            expect(Stripe::Checkout::Session).to have_received(:create).with(hash_including(customer: "1"))
        end
    end 
end 