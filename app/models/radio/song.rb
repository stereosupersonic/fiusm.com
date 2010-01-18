class Song < ActiveRecord::Base
  has_many :plays, :class_name => 'SongPlay'
  validates_presence_of :artist, :title
end