class RemoveCanvasExtras < ActiveRecord::Migration
  def self.up
    rename_column :canvases, :columns, :assigns
    drop_table :canvas_item_templates
  end

  def self.down
    create_table "canvas_item_templates", :force => true do |t|
      t.string   "name"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    rename_column :canvases, :assigns, :columns
  end
end
