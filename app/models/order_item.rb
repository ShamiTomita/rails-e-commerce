class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :line_item
  
  def total_price
    tp = self.quantity * self.product.price
    tp.to_f
  end
end
