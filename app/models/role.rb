class Role < ActiveRecord::Base
  validates_uniqueness_of :title, :scope => 'user_id'
  belongs_to :user
end
