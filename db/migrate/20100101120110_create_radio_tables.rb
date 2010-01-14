class CreateRadioTables < ActiveRecord::Migration
  def self.up
    create_table "radio_genres", :force => true do |t|
      t.string "name"
    end

    create_table "radio_hostings", :force => true do |t|
      t.integer  "host_id"
      t.integer  "show_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "radio_hosts", :force => true do |t|
      t.string   "name"
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.text     "bio"
      t.string   "title"
      t.date     "birth_date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "level"
      t.string   "permalink"
    end

    create_table "radio_session_breaks", :force => true do |t|
      t.integer  "after_song_id"
      t.datetime "started_at"
      t.datetime "ended_at"
    end

    create_table "radio_sessions", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.datetime "started_at"
      t.datetime "ended_at"
      t.string   "type",       :default => "MusicSession", :null => false
      t.string   "dj_name"
    end

    create_table "radio_shows", :force => true do |t|
      t.string   "name"
      t.string   "day"
      t.string   "long_genre"
      t.integer  "hour_start"
      t.integer  "hour_end"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "logo_file_name"
      t.string   "logo_content_type"
      t.integer  "logo_file_size"
      t.integer  "genre_id"
      t.string   "permalink"
      t.string   "host_name"
      t.text     "description"
    end
  end

  def self.down
    drop_table "radio_genres"
    drop_table "radio_hostings"
    drop_table "radio_hosts"
    drop_table "radio_session_breaks"
    drop_table "radio_sessions"
    drop_table "radio_shows"
  end
end
