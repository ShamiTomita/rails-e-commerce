class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy

  scope :filter_by_low_water, -> {select {|p| p.low_water === true}}
  scope :filter_by_med_water, -> {select {|p| p.med_water === true}}
  scope :filter_by_high_water, -> {select {|p| p.high_water === true}}
  def self.ransackable_attributes(auth_object = nil)
    ["name", "pet_friendly"]
  end

#####water methods#####
  def low_water
    if self.watering.match(/drought/)
      return true
    else
      false
    end
  end

  def med_water
    if self.watering.match(/dry/)
      return true
    else
      false
    end
  end

  def high_water
    if self.watering.match(/thoroughly/)
      return true
    else
      false
    end
  end





end
