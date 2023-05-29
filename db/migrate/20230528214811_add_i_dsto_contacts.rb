class AddIDstoContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :user_id, :integer
    add_column :contacts, :product_id, :integer
    add_column :contacts, :order_id, :integer
  end
end
