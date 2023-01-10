require 'rails_helper'
require 'stripe_mock'
#am I on the right track? should I seperate these out?
#Checkout Placing an order
#test doubles 

RSpec.describe "checkout", type: :system do
    #should I do all set up in here first as in create user, sign in, within a before_block???
    let(:cart) {create(:cart)}
    let!(:product) {create(:product)} ###removing this line results in an "undefined local variable"
    let(:line_item) {create(:line_item)}
    let(:stripe_helper) { StripeMock.create_test_helper }
    before{ StripeMock.start }
    after{ StripeMock.stop }

    describe "Checkout Setup" do 
        before(:each) do 
            login_as(create(:user))
            @current_cart = cart #i guess this should be the before action:current_cart in the application_controller?? I should test that
            #### my tests seem to only pass when this is here even though I already have it definied above
            ####removing the above line seems to remove the product from the products/index
            visit products_path
        end 
        #signed in user can add items
        #make tests more independent
        it "check for signed in user" do #Step 0
            find('#user-menu-button').click
            expect(page).to have_content("Your Profile")
        end
        #add more detail if its the main product 
        #bulletted list 
        it "assigns a cart to the session" do 
            expect(@current_cart).to eq(cart)
        end 

        it "shows the product page with products" do 
            #product 
            expect(page).to have_text("Shop Plants!")
            expect(page).to have_text("Add to cart")
        end 
        it "allows for adding items to cart" do 
            cart.line_items.push(line_item)
            expect(@current_cart.line_items).to include(line_item)
            expect(@current_cart.line_items.length).to eq(1)
            expect(@current_cart.sub_total).to eq(line_item.total_price)
        end 
        it "allows for checkout" do 
            cart.line_items.push(line_item)
            find("#cart-menu-button").click 
            expect(page).to have_content("#{line_item.total_price}")
            expect(page).to have_content("Checkout")
        end 

    end 
    describe "Get Checkout" do 
        before(:each) do
            user = create(:user)
            sign_in user
            @order = create(:order, user_id:user.id, cart_id:cart.id)
            @order_item = create(:order_item, product_id:product.id, order_id:@order.id, line_item_id:line_item.id, quantity:1)
            @order.order_items.push(@order_item)
        end 

        it "successfully loads checkout page" do 
            visit "/orders/#{@order.id}"
            expect(page).to have_content("Pending Order")
            expect(page).to have_content("#{@order_item.quantity}")
            expect(page).to have_content("#{@order_item.total_price}")
            expect(page).to have_content("Total Price: #{cart.sub_total}")
            expect(page).to have_no_content "Your cart"
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
            pending("ugh")
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

        it "adds the submitted order to profile page" do 
            @order.status = "order_submitted"
            @order.save 

            visit profile_path
            expect(page).to have_content("Your Profile!")
            expect(page).to have_content("Ordered #{@order.created_at.strftime("%Y-%m-%d")}")
        end 

    end 
end 