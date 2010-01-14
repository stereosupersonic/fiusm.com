class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :headline
      t.string :summary
      t.text :raw_body

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
