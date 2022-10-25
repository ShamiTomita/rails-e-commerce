class ChangeOrders < ActiveRecord::Migration[7.0]
  def change
    rename_column :orders, :shipping_address, :street_address
    add_column :orders, :state, :string
    add_column :orders, :zipcode, :string
    add_column :orders, :city, :string
  end
end
