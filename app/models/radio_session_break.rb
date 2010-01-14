class RadioSessionBreak < ActiveRecord::Base

  belongs_to :play, :class_name => 'SongPlay', :foreign_key => 'after_song_id'

  validates_presence_of :after_song_id, :started_at
  
  def end!(time = DateTime.now)
    update_attribute(:ended_at, time)
  end
  
  def playing?
    !ended_at
  end
  
  def ended?
    ended_at
  end

end
# == Schema Information
#
# Table name: radio_session_breaks
#
#  id            :integer         not null, primary key
#  after_song_id :integer
#  started_at    :datetime
#  ended_at      :datetime
#

