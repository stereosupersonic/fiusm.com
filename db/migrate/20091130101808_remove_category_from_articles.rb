class RemoveCategoryFromArticles < ActiveRecord::Migration
  def self.up
    remove_column :articles, :category_id
  end

  def self.down
    add_column :articles, :category_id, :integer
  end
end
