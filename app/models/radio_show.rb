class RadioShow < ActiveRecord::Base
  validates_presence_of :name, :genre_id
  validates_uniqueness_of :name

  has_attached_file :logo, :styles => { :thumbnail => '56x56#', :medium => '128x128#', :large => '256x256#' }
  # has_permalink :name

  belongs_to :genre, :class_name => 'RadioGenre', :foreign_key => 'genre_id'
  has_many :hostings, :class_name => 'RadioHosting', :foreign_key => 'show_id'
  has_many :hosts, :through => :hostings

  def human_times
    hour_start, hour_end =
      [self.hour_start, self.hour_end].collect do |original_hour|
        hour = original_hour
        hour = hour % 12
        hour = 12 if hour == 0
        hour = hour.to_s
        hour += original_hour >= 12 ? 'pm' : 'am'
      end
    "#{day} #{hour_start}-#{hour_end}"
  end

  def to_param
    permalink || id.to_s
  end
end
# == Schema Information
#
# Table name: radio_shows
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  day               :string(255)
#  long_genre        :string(255)
#  hour_start        :integer
#  hour_end          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer
#  genre_id          :integer
#  permalink         :string(255)
#  host_name         :string(255)
#  description       :text
#

