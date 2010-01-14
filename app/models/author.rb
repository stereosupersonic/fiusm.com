class Author < ActiveRecord::Base
  has_many :authorships
  has_many :articles, :through => :authorships
end

# == Schema Information
#
# Table name: authors
#
#  id    :integer         not null, primary key
#  name  :string(255)
#  title :string(255)
#

