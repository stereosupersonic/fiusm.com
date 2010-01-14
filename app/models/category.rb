# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  url        :string(255)
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base

  default_scope :conditions => 'parent_id IS NULL', :order => 'position ASC'

  acts_as_tree :order => "name"
  acts_as_list
  
  has_many :categorizations

  module ArticleAssociationExtensions
    def featured
      first
    end
    
    def highlighted
      returning [] do |array|
        array << featured
      end
    end
  end
  
  has_many :articles,
    :through => :categorizations, :source => :categorizable,
    :source_type => 'Article', :conditions => '"categorizations".categorizable_type = "Article"',
    :extend => ArticleAssociationExtensions
  
  before_validation :create_url
  
  def to_param
    url
  end
  
  private

    def create_url
      self.url = name.to_s.parameterize
    end

end
