class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :orders
  has_many :line_items, dependent: :destroy
  has_many :contacts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

  after_initialize :set_default_role, :if => :new_record?

  validates :email,
    :presence => :true,
    :format => {
      :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
      :message => "must be a valid email address"
    }
    
  def set_default_role
    self.role ||= "user"
  end

  def shipping_address
    if !!self.city
      return (self.address + " " + self.city + " " + self.state + " " + self.zipcode)
    else
      return nil
    end 
  end
end
