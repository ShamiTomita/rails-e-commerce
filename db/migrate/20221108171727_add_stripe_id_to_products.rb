class AddStripeIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :stripe_id, :string
  end
end
