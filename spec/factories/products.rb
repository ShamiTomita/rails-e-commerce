FactoryBot.define do
  factory :product do
    id {999}
    name {"dummy"}
    description {"dumb plant"}
    light {"dumb light"}
    watering {"dumb water"}
    temp {"dumb temp"}
    img {"dumb.png"}
    price {1.00}
    pet_friendly {true}
  end
end
