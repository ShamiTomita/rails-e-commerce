include ActionView::Helpers::NumberHelper
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def total_price
    tp = self.quantity * self.product.price
    number_to_currency(tp)
  end

end
