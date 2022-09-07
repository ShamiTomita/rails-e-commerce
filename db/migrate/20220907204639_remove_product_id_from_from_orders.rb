class RemoveProductIdFromFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :product_id, :integer
    add_column :orders, :payment_method, :string
  end
end
