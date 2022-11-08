class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  has_many :order_items
  enum status: [:not_ordered, :order_submitted, :order_in_progress, :order_in_transit, :order_completed]


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
end
