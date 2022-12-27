FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Plantus #{n}" }
    description {"dumb plant"}
    light {"dumb light"}
    watering {"dumb water"}
    temp {"dumb temp"}
    img {"plants/dumb.png"}
    price {1.00}
  end
end
