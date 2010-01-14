class CreateShit < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string  :title
      t.string  :credit
      t.text    :caption
      
      t.string :file_file_name
      t.string :file_content_type
      t.string :file_file_size
      t.string :file_updated_at
      
      t.integer :gallery_id
      t.timestamps
    end
    create_table :attachments do |t|
      t.string  :owner_type
      t.integer :owner_id
      t.string  :asset_type
      t.integer :asset_id
      t.timestamps
    end
    create_table :galleries do |t|
      t.string :name
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
    drop_table :attachments
    drop_table :images
  end
end
