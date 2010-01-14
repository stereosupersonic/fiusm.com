class Authorship < ActiveRecord::Base
  belongs_to :author
  belongs_to :article
end
# == Schema Information
#
# Table name: authorships
#
#  id         :integer         not null, primary key
#  article_id :integer
#  author_id  :integer
#

