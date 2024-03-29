class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :order_items
  has_many :products, through: :order_items
  has_many :contacts 
  
  enum status: [:not_ordered, :order_submitted, :order_in_progress, :order_in_transit, :order_completed]
  #TO DO 
  #scope for highest price order
  #scope for lowest price order 
  validates :user_id, presence: true 
  validates :cart_id, presence: true
  
  scope :chronological, -> {order(created_at: :asc)}
  def shipping_address
    if !!self.city
      return (self.street_address + " " + self.city + " " + self.state + " " + self.zipcode)
    else
      return nil
    end
  end

  def name
    return (self.first_name + " " + self.last_name)
  end 

   def sub_total
    sum = 0
    self.order_items.each do |line_item|
      sum+= order_item.total_price
    end
    return sum
  end
end
