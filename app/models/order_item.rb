class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :line_item

  validates :product_id, presence: true
  validates :order_id, presence: true
  validates :line_item_id, presence: true

  def total_price
    tp = self.quantity * self.product.price
    tp.to_f
  end
end
