class AddMissingRadioTables < ActiveRecord::Migration
  def self.up
    create_table "radio_towers", :force => true do |t|
      t.string  "name"
      t.decimal "latitude",  :precision => 15, :scale => 10
      t.decimal "longitude", :precision => 15, :scale => 10
      t.float   "frequency"
      t.string  "permalink"
    end

    create_table "song_plays", :force => true do |t|
      t.integer  "session_id"
      t.integer  "song_id"
      t.datetime "started_at"
      t.datetime "ended_at"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "radio_session_id"
    end

    create_table "songs", :force => true do |t|
      t.string   "album"
      t.string   "artist"
      t.string   "title"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
    drop_table :radio_towers
    drop_table :song_plays
    drop_table :songs
  end
end