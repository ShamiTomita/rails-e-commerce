class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :light
      t.string :watering
      t.string :temp
      t.string :img
      t.decimal :price
      t.boolean :pet_friendly

      t.timestamps
    end
  end
end
