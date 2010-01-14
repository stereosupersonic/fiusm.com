class AddPublicationDatesToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :first_published_version, :integer
    add_column :articles, :published_version, :integer
    add_column :articles, :publish_at, :datetime
  end

  def self.down
    remove_column :articles, :publish_at
    remove_column :articles, :published_version
    remove_column :articles, :first_published_version
  end
end
