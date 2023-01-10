require 'rails_helper'

RSpec.describe "ProductsController", type: :request do 
    #actually this is my filter, i dont know what to call these
    describe "GET /products" do
        it "successfully loads the products index path" do  
            get products_path
            expect(response).to have_http_status(200)
        end
        ##########################################################################
        it "successfully filters a product with a low water maintenance level" do
            plant = create(:product, name:"test me!", watering:"drought")
            get "/products", :params => {:filter => "water", :filter_option =>"low"}
            expect(response.body).to include("test me!")
        end 

        it "successfully filters a product with a med light maintenance level" do
            plant = create(:product, name:"test me! but with light!", light:"indirect")
            get "/products", :params => {:filter => "light", :filter_option =>"med"}
            expect(response.body).to include("test me! but with light!")
        end

        it "successfully filters a product with hight temp level" do 
            plant = create(:product, name: "temp test baby", temp:"90")
            get "/products", :params => {:filter => "temp", :filter_option =>"high"}
            expect(response.body).to include("temp test baby")
        end

        it "successfully filters OUT a product without high water maintenance" do 
            plant = create(:product, name:"I Shouldnt Be Here", watering:"drought")
            get "/products", :params => {:filter => "water", :filter_option =>"high"}
            expect(response.body).not_to include("I Shouldnt Be Here")
        end
    end 
end 