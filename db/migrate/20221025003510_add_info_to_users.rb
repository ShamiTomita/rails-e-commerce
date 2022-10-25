class AddInfoToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :city, :string
    add_column :users, :zipcode, :string
    add_column :users, :state, :string
    add_column :users, :phone, :string
  end
end
