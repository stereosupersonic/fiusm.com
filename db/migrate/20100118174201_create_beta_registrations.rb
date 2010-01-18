class CreateBetaRegistrations < ActiveRecord::Migration
  def self.up
    create_table :beta_registrations do |t|
      t.string :name
      t.integer :facebook_uid
      
      t.boolean :activated, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_registrations
  end
end
