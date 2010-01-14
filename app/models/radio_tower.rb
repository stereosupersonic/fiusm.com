class RadioTower < ActiveRecord::Base
  validates_presence_of :name, :latitude, :longitude, :frequency
  # has_permalink :name
  
  def to_param
    permalink || id.to_s
  end
end