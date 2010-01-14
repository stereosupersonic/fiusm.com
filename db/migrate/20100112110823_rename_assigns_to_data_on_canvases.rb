class RenameAssignsToDataOnCanvases < ActiveRecord::Migration
  def self.up
    rename_column :canvases, :assigns, :data
  end

  def self.down
    rename_column :canvases, :data, :assigns
  end
end