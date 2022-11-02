class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["name", "pet_friendly"]
  end
end
