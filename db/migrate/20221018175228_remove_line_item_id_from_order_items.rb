class RemoveLineItemIdFromOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_items, :line_item_id
  end
end
