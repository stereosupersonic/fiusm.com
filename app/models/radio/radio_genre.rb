class RadioGenre < ActiveRecord::Base
  has_many :shows, :class_name => 'RadioShow', :foreign_key => 'genre_id', :order => 'name asc'

  def to_s
    name
  end
end
# == Schema Information
#
# Table name: radio_genres
#
#  id   :integer         not null, primary key
#  name :string(255)
#

