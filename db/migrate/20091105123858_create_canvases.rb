class CreateCanvases < ActiveRecord::Migration
  def self.up
    create_table :canvases do |t|
      t.string :name
      t.string :key
      t.text :columns

      t.timestamps
    end
  end

  def self.down
    drop_table :canvas
  end
end
