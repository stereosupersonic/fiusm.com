# == Schema Information
#
# Table name: galleries
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Gallery < ActiveRecord::Base

  has_many :images, :dependent => :destroy
  has_many :attachments, :as => :asset, :class_name => '::Attachment'

  def owners
    attachments.collect { |a| a.owner }
  end

  def owned?
    !attachments.empty?
  end

  def image_after(image)
    images.find(:first, :conditions => ['id > ?', image.id], :order => 'id asc')
  end

  def image_before(image)
    images.find(:first, :conditions => ['id < ?', image.id], :order => 'id desc')
  end
  
  def self.attachable?
    true
  end

end
