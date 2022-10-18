class AddQauntityAndProductIdToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :quantity, :integer
    add_column :order_items, :product_id, :integer
  end
end
