class AddCompletedToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :completed, :boolean, default:false
  end 
end
