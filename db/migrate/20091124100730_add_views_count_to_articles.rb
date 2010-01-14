class AddViewsCountToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :views_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :articles, :views_count
  end
end
