class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :order_items
  enum status: [:not_ordered, :order_submitted, :order_in_progress, :order_in_transit, :order_completed]
end
