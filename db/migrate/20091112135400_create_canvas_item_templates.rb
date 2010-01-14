class CreateCanvasItemTemplates < ActiveRecord::Migration
  def self.up
    create_table :canvas_item_templates do |t|
      t.string :name
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :canvas_item_templates
  end
end
