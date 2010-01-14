class CreateAuthors < ActiveRecord::Migration
  def self.up
    create_table :authors do |t|
      t.string :name
      t.string :title
    end
    
    create_table :authorships do |t|
      t.integer :article_id
      t.integer :author_id
    end
  end

  def self.down
    drop_table :authors
  end
end
