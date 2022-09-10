class ChangeQuantityColumnInLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column_default :line_items, :quantity, from: nil, to: 1
  end
end
