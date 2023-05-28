class Contact < ActiveRecord::Base

  validates :email,
    :presence => :true,
    :format => {
      :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
      :message => "must be a valid email address"
    }
  validates :message, :presence => :true

   enum :issue_type, {inquiry: 0, product_issue: 1, account: 2, order_issue: 3, billing: 4}

   belongs_to :user, optional: true 
   belongs_to :product, optional: true 
   belongs_to :order, optional: true 

end
