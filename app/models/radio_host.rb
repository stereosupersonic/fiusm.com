class RadioHost < ActiveRecord::Base
  has_many :hostings, :class_name => 'RadioHosting', :foreign_key => 'host_id'
  has_many :shows, :through => :hostings
  has_attached_file :avatar, :styles => { :bio_page => "200x", :card_icon => "64x64#", :small_card_icon => "48x48#" }
  # has_permalink :name
  
  def to_param
    permalink
  end
end

# == Schema Information
#
# Table name: radio_hosts
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  bio                 :text
#  title               :string(255)
#  birth_date          :date
#  created_at          :datetime
#  updated_at          :datetime
#  level               :string(255)
#  permalink           :string(255)
#

