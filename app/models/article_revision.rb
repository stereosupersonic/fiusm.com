# == Schema Information
#
# Table name: articles
#
#  id                         :integer         not null, primary key
#  headline                   :string(255)
#  summary                    :string(255)
#  raw_body                   :text
#  created_at                 :datetime
#  updated_at                 :datetime
#  revisable_original_id      :integer
#  revisable_branched_from_id :integer
#  revisable_number           :integer         default(0)
#  revisable_name             :string(255)
#  revisable_type             :string(255)
#  revisable_current_at       :datetime
#  revisable_revised_at       :datetime
#  revisable_deleted_at       :datetime
#  revisable_is_current       :boolean         default(TRUE)
#  views_count                :integer         default(0), not null
#  permalink                  :string(255)
#  first_published_version    :integer
#  published_version          :integer
#  publish_at                 :datetime
#

class ArticleRevision < Article
  acts_as_revision :revisable_class_name => "Article"
end
