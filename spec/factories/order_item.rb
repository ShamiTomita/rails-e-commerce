FactoryBot.define do 
    factory :order_item do 
        order
        product 
        line_item 
    end 
end 