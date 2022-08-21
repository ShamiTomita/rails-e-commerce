json.extract! product, :id, :name, :description, :light, :watering, :temp, :img, :price, :pet_friendly, :created_at, :updated_at
json.url product_url(product, format: :json)
