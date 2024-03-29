# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Product.create!(name:"Devils Ivy", price:40.00, description:"Pothos, aka Devil’s Ivy, features trailing green & yellow, heart-shaped foliage with white marble variegation", light:"Indirect light; can tolerate lower light", watering:"When top 1' of soil is dry to the touch; do not allow soil to stay too wet or dry for extended periods of time", temp:"60-80", img:"plants/devils_ivy.png", pet_friendly:false)
Product.create!(name:"Parlor Palm Plant", price:45.00, description:"Parlor Palm is a beautiful, multi-stemmed plant with fun, feathery fronds at top", light:"Thrives in bright, indirect light. Also tolerates low light", watering:"In general, weekly; water more often during growing season, but keep it light during the winter", temp:"65-90", img:"plants/parlor_palm_plant.png", pet_friendly:false)
Product.create!(name:"Snake Plant", price:68.00, description:"Tall, green blade-like leaves with subtle light green striping", light:"Low light/partial shade, though ok in moderate indirect light", watering:"Drought tolerant. Water only when soil is dry to touch", temp:"65-90", img:"plants/snake_plant.png", pet_friendly:false)
Product.create!(name:"Money Tree Plant", price:132.00, description:"Money Tree Plant features a uniquely braided trunk with clusters of green leaves at top", light:"Prefers bright, indirect light", watering:"Do it thoroughly once a week, and let the soil dry between waterings", temp:"65-90", img:"plants/money_tree.png", pet_friendly:true)
Product.create!(name:"Rubber Plant", price:68.00, description:"Raindrop Peperomia, aka Baby Rubber Plant, features thick, dark-green, variegated succulent leaves that have a light silver stripe down the midvein", light:"Medium to bright light; no direct sunlight", watering:"When top 1' of soil is dry to touch; leaves are succulent in nature and can tolerate less watering", temp:"60-90", img:"plants/rubber_plant.png", pet_friendly:true)
Product.create!(name:"Peace Lilly", price:55.00, description:"Peace Lily plant has broad, dark green leaves and the occasional white calla lily flower on a tall stem
", light:"Best in bright, indirect light; can tolerate low light levels, but will produce more blooms with more light", watering:"Once a week, or when top inch of soil is dry", temp:"65-90", img:"plants/peace_lilly.png", pet_friendly:false)
Product.create!(name:"Zz Plant", price:72.00, description:"ZZ Floor Plant has deep green leaves that alternate on the stem in a herringbone pattern
", light:"Low to moderate light; indirect sunlight", watering:"Water when top 1” of soil is dry to the touch", temp:"60-90", img:"plants/zz_plant.png", pet_friendly:false)
Product.create!(name:"Red Anthurium", price:65.00, description:"Bright, glossy leaves with 4+ red, heart-shaped blooms", light:"Medium to bright light will encourage max blooms", watering:"Place 6 ice cubes on top of soil or ½ a cup of water per week", temp:"65-85", img:"plants/red_anthurium_plant.png", pet_friendly:false)
Product.create!(name:"Diffenbachia Plant", price:40.00, description:"Dumb cane plant (aka Dieffenbachia maculata) has medium green leaves speckled with creamy yellow centers", light:"Bright, indirect light. Will tolerate low light as well", watering:"Once a week, when top soil is dry", temp:"65-90", img:"plants/dieffenbachia_plant.png", pet_friendly:false)
Product.create!(name:"Monstera Plant", price:130.00, description:"Bush-like in shape with stems featuring large cutout leaves
", light:"Grows faster in a bright, indirect sunlight spot but also tolerates low light", watering:"Water it enough to keep the soil from drying out completely - but it is semi drought tolerant!", temp:"65-90", img:"plants/monstera_plant.png", pet_friendly:false)
Product.create!(name:"Fiddle Leaf Fig Plant", price:135.00, description:"Fiddle leaf fig has a narrow stem with big, dark green, fiddle-shaped leaves
", light:"Set it by a bright & sunny window for consistent light", watering:"Water thoroughly but only when soil is dry to the touch!", temp:"65-90", img:"plants/fiddle_leaf_fig_plant.png", pet_friendly:false)
Product.create!(name:"String of Pearls Succulents", price:72.00,description:"String of Pearls is a trailing vine with dense, round shaped foliage
", light:"Bright, indirect light...but if grown outside, needs warm filtered light", watering:"Thristier in warmer months than cold, its best to water when soil is dry to the touch. Let soil dry between waterings.", temp:"65-90", img:"plants/string_of_pearls_succulents.png", pet_friendly:false)
Product.create!(name:"Birds of Paradise", price:120.00,  description:"Birds of Paradise Floor plant features long, banana-like glossy leaves
", light:"Lots of bright, direct sunlight helps this plant to flourish; a sunroom or outdoors is best", watering:"Keep soil moist spring through fall; in the winter, allow top 2' to dry out before watering", temp:"60-80", img:"plants/birds_of_paradise.png", pet_friendly:false)
Product.create!(name:"Bromeliad", price:88.00, description:"The Vriesea Intenso Orange, or flaming sword houseplant, is one of the showiest bromeliads known for its bright orange spike, lasting as long as 3–6 months. It is a colorful, easy indoor plant that will brighten up any space. Added bonus, it's non-toxic, making it safe to keep around curious pets.", light:"Thrives in bright indirect light, but can tolerate a few hours of direct sun.", watering:"Each week, add water to the leaf cups (water tank), the center area created by overlapping leaves. As water cups tend to collect debris and insects, empty out each week and add new water. Bromeliads can be sensitive to hard tap water. Try using filtered water or leaving water out overnight before using. For best results, mist weekly and provide an additional source of humidity like a pebble tray or humidifier.", temp:"65-90", img:"plants/bromeliad.jpg", pet_friendly:true)
Product.create!(name:"Button Fern", price:74, description:"Despite the Button Fern's appearance, with adorable button-like leaflets attached to delicate stems, it is a tough little fern: On the cliffs of its native New Zealand, it can withstand a variety of temperatures and humidity. This plant is pet-friendly!", light:"Thrives in bright indirect light. Not suited for low light conditions or direct sun.", watering:"Water every 1-2 weeks allowing soil to dry out halfway between waterings. Expect to water more oftern in brighter light and less often in lower light. This plant can benefit from higher humidity but can tolerate normal room humidity levels.", temp:"65-90", img:"plants/button_fern.jpg")
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
def create_products
      Product.all.each do |product|
        if !product.stripe_id
          price = product.price*100
          p = Stripe::Product.create(
          {
            name: product.name,
            default_price_data: {
              unit_amount: price.to_f.to_i,
              currency: 'usd',
            },
            images:[product.img],
            description: product.description,
            expand: ['default_price'],
          },
          )
          product.stripe_id = p.id
          product.save
        end
      end
    end

    def create_prices
      Product.all.each do |product|
        if product.stripe_id
          price = product.price*100
          Stripe::Price.create({
            unit_amount: price.to_f.to_i,
            currency: 'usd',
            product: product.stripe_id,
            })
        end
      end
    end

    create_products
    create_prices