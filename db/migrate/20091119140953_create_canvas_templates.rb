class CreateCanvasTemplates < ActiveRecord::Migration
  def self.up
    create_table :canvas_templates do |t|
      t.string :name
      t.text :source

      t.timestamps
    end
  end

  def self.down
    drop_table :canvas_templates
  end
end
