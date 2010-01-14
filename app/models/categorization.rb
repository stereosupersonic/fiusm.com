# == Schema Information
#
# Table name: categorizations
#
#  id                 :integer         not null, primary key
#  categorizable_type :string(255)
#  categorizable_id   :integer
#  category_id        :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Categorization < ActiveRecord::Base
  validates_uniqueness_of :category_id, :scope => [:categorizable_type, :categorizable_id]
  
  belongs_to :categorizable, :polymorphic => true
  belongs_to :category
end
