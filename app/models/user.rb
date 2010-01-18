# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  name              :string(255)     not null
#  facebook_uid      :integer         not null
#  persistence_token :string(255)
#  admin             :boolean         default(FALSE), not null
#  dj                :boolean         default(FALSE), not null
#  writer            :boolean         default(FALSE), not null
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  validates_presence_of :name, :facebook_uid
  
  has_many :roles

  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end
  
  def role_symbols=(roles)
    roles.each do |role|
      raise ArgumentError unless role.is_a?(Symbol)
      self.roles.find_or_create_by_title(role.to_s)
    end
  rescue ArgumentError => e
    e.message = 'role_symbols= only accepts an array of symbols'
    raise e
  end
  
  def admin!
    roles.find_or_create_by_title 'admin'
  end
  
  def to_fb
    @to_fb ||= Facebooker::User.new(facebook_uid)
  end

end