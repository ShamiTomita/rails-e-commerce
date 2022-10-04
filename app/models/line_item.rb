include ActionView::Helpers::NumberHelper
class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  belongs_to :user
  after_create_commit { broadcast_update_to "cart"}
  after_update_commit {broadcast_replace_to "cart"}
  def total_price
    tp = self.quantity * self.product.price
    tp.to_f
  end

end
