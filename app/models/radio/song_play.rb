class SongPlay < ActiveRecord::Base

  belongs_to :session, :class_name => 'RadioSession'
  belongs_to :song

  has_one :break_after, :class_name => 'RadioSessionBreak', :foreign_key => 'after_song_id', :dependent => :destroy
  
  validates_associated :song

  named_scope :played, :conditions => 'ended_at IS NOT NULL OR (ended_at IS NULL AND started_at IS NOT NULL)', :order => 'ended_at DESC', :include => :song
  
  def self.latest
    played.first
  end
  
  def play!
    if session.current_song
      raise "Cannot play because there is a song already playing."
    elsif self != session.next_song
      raise "Cannot play because this is not the next song in the session."
    elsif session.on_break?
      raise "Cannot play because the session is on a break right now."
    else
      update_attributes!(:started_at => DateTime.now)
    end
  end
  
  def end!(time = DateTime.now)
    if playing?
      update_attribute(:ended_at, time)
    elsif ended?
      raise "Cannot end a song that has already ended!"
    else
      raise "Cannot end a song that has not started!"
    end
  end
  
  def break!(time = nil)
    create_break_after(:started_at => (time || DateTime.now))
  end
  
  def next_song?
    current = session.plays.select { |p| p.current_song? }[0]
    if current.nil?
      if self.previous
        return false
      else
        return true
      end
    else
      current.next == self
    end
  end
  
  def next
    session.plays.find(:first, :conditions => ['id > ?', self.id], :order => 'id asc')
  end
  
  def previous
    session.plays.find(:first, :conditions => ['id < ?', self.id], :order => 'id desc') ||
      session.plays.find(:first, :order => 'id desc')
  end
  
  def current_song?
    ended_at.nil? && !started_at.nil?
  end
  
  def now_playing?
    current_song?
  end
  
  def playing?
    now_playing?
  end
  
  def ended?
    ended_at ? true : false
  end
  
  def played?
    ended?
  end
  
  def pending?
   ended_at.nil? && started_at.nil? 
  end

  def breaks_after?
    break_after
  end

end