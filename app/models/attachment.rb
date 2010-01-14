# == Schema Information
#
# Table name: attachments
#
#  id         :integer         not null, primary key
#  owner_type :string(255)
#  owner_id   :integer
#  asset_type :string(255)
#  asset_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Attachment < ActiveRecord::Base
  
  validates_presence_of :owner_type, :owner_id, :asset_type, :asset_id
  validates_associated  :owner, :asset
  
  belongs_to :owner, :polymorphic => true
  belongs_to :asset, :polymorphic => true
  
  before_validation :create_asset, :if => :new_record?
  
  after_destroy do |record|
    record.asset.destroy if record.asset.owners.empty?
  end
  
  def type
    asset.class
  end
  
  def attached_at
    created_at
  end
  
  def create_asset(attributes = {})
    self.asset = asset_type.constantize.create(attributes) if asset_type
  end
  
end
