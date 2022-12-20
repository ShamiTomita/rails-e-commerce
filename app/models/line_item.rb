include ActionView::Helpers::NumberHelper
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :user
  has_one :order_item

  validates :product_id, presence: true 
  validates :cart_id, presence: true 
  validates :user_id, presence: true 

  def total_price
    tp = self.quantity * self.product.price
    tp.to_f
  end

end
