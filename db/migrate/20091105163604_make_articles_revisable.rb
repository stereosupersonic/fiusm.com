class MakeArticlesRevisable < ActiveRecord::Migration
  def self.up
        add_column :articles, :revisable_original_id, :integer
        add_column :articles, :revisable_branched_from_id, :integer
        add_column :articles, :revisable_number, :integer, :default => 0
        add_column :articles, :revisable_name, :string
        add_column :articles, :revisable_type, :string
        add_column :articles, :revisable_current_at, :datetime
        add_column :articles, :revisable_revised_at, :datetime
        add_column :articles, :revisable_deleted_at, :datetime
        add_column :articles, :revisable_is_current, :boolean, :default => true
      end

  def self.down
        remove_column :articles, :revisable_original_id
        remove_column :articles, :revisable_branched_from_id
        remove_column :articles, :revisable_number
        remove_column :articles, :revisable_name
        remove_column :articles, :revisable_type
        remove_column :articles, :revisable_current_at
        remove_column :articles, :revisable_revised_at
        remove_column :articles, :revisable_deleted_at
        remove_column :articles, :revisable_is_current
      end
end
