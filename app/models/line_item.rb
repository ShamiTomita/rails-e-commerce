include ActionView::Helpers::NumberHelper
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :user

  def total_price
    tp = self.quantity * self.product.price
    tp.to_f
  end

end
