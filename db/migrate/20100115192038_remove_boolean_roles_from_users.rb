class RemoveBooleanRolesFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :admin
    remove_column :users, :dj
    remove_column :users, :writer
  end

  def self.down
    add_column :users, :admin,  :boolean
    add_column :users, :dj,     :boolean
    add_column :users, :writer, :boolean
  end
end
