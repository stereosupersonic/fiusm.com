class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :name,              :null => false
      t.integer :facebook_uid,      :null => false
      t.string  :persistence_token
      
      
      t.boolean :admin,  :default => 0, :null => false
      t.boolean :dj,     :default => 0, :null => false
      t.boolean :writer, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
