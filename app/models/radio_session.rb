class RadioSession < ActiveRecord::Base

  has_many :plays, :foreign_key => 'session_id', :dependent => :destroy

  validates_presence_of :started_at
  validate :anyone_else_on
  
  def self.current
    find(:first, :conditions => "started_at IS NOT NULL AND ended_at IS NULL")
  end
  
  def playing?
    plays.find(:first)
  end
  
  def onair?
    started_at && !ended_at
  end
  
  def onair!
    unless started_at
      started_at = Time.now
    else
      raise "This radio session has already been started!"
    end
  end
  
  def offair!
    if started_at
      unless ended_at
        ended_at = Time.now
      else
        raise "This radio session has already been ended!"
      end
    else
      raise "This radio session hasn't even been started yet!"
    end
  end

  def status
    onair? ? :onair : :offair
  end

  protected
    def anyone_else_on
      if self.class.current
        errors.add_to_base("There is an active radio session already!")
      end
    end

end
# == Schema Information
#
# Table name: radio_sessions
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  started_at :datetime
#  ended_at   :datetime
#  type       :string(255)     default("MusicSession"), not null
#  dj_name    :string(255)
#

