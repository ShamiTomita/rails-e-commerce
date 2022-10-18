class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.integer :line_item_id
      t.integer :order_id
      
      t.timestamps
    end
  end
end
