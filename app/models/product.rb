class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  validates :name, presence: true
  validates :price, presence: true 

  scope :filter_by_water, -> (watering) {where("watering LIKE ?", "%#{watering}%")}
                                  #where column like query
  scope :filter_by_light, -> (light) {where("light LIKE ?", "%#{light}%")}

  scope :filter_by_temp, -> (temp) {where("temp LIKE ?", "%#{temp}%")}

  scope :filter_light, -> (light) {where("light LIKE ?", "%#{light}")}

  #scope :filter_by_med_water, -> {select {|p| p.med_water === true}}
  #scope :filter_by_high_water, -> {select {|p| p.high_water === true}}

  #scope :filter_by_low_temp, -> {select {|p| p.low_temp === true}}
  #scope :filter_by_med_temp, -> {select {|p| p.med_temp === true}}
  #scope :filter_by_high_temp, -> {select {|p| p.high_temp === true}}

  #scope :filter_by_low_light, -> {select {|p| p.low_light === true}}
  #scope :filter_by_med_light, -> {select {|p| p.med_light === true}}
  #scope :filter_by_high_light, -> {select {|p| p.high_light === true}}

  scope :low_to_high, -> {order(price: :asc)}
  scope :high_to_low, -> {order(price: :desc)}
  
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

##### temp methods

  def low_temp
    t = self.temp.split("-")
    if t[0].to_i <= 60
      return true
    else
      false
    end
  end

  def med_temp
    t = self.temp.split("-")
    if t[1].to_i <= 80
      return true
    else
      false
    end
  end

  def high_temp
    t = self.temp.split("-")
    if t[1].to_i >= 90
      return true
    else
      false
    end
  end

######light requirements

  def low_light
    if self.light.match(/shade/) || self.light.match(/tolerate/)
      return true
    else
      false
    end
  end

  def med_light
    if self.light.match(/medium/) || self.light.match(/indirect/)
      return true
    else
      false
    end
  end

  def high_light
    if self.light.match(/bright/)
      return true
    else
      false
    end
  end



end
