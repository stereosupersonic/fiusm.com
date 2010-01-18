# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100118174201) do

  create_table "articles", :force => true do |t|
    t.string   "headline"
    t.string   "summary"
    t.text     "raw_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "revisable_original_id"
    t.integer  "revisable_branched_from_id"
    t.integer  "revisable_number",           :default => 0
    t.string   "revisable_name"
    t.string   "revisable_type"
    t.datetime "revisable_current_at"
    t.datetime "revisable_revised_at"
    t.datetime "revisable_deleted_at"
    t.boolean  "revisable_is_current",       :default => true
    t.integer  "views_count",                :default => 0,    :null => false
    t.string   "permalink"
    t.integer  "first_published_version"
    t.integer  "published_version"
    t.datetime "publish_at"
  end

  create_table "attachments", :force => true do |t|
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "asset_type"
    t.integer  "asset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", :force => true do |t|
    t.string "name"
    t.string "title"
  end

  create_table "authorships", :force => true do |t|
    t.integer "article_id"
    t.integer "author_id"
  end

  create_table "beta_registrations", :force => true do |t|
    t.string   "name"
    t.integer  "facebook_uid"
    t.boolean  "activated",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "canvas_templates", :force => true do |t|
    t.string   "name"
    t.text     "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "canvases", :force => true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "categorizations", :force => true do |t|
    t.string   "categorizable_type"
    t.integer  "categorizable_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.string   "credit"
    t.text     "caption"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.string   "file_file_size"
    t.string   "file_updated_at"
    t.integer  "gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "radio_towers", :force => true do |t|
    t.string  "name"
    t.decimal "latitude",  :precision => 15, :scale => 10
    t.decimal "longitude", :precision => 15, :scale => 10
    t.float   "frequency"
    t.string  "permalink"
  end

  create_table "roles", :force => true do |t|
    t.string  "title"
    t.integer "user_id"
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

  create_table "users", :force => true do |t|
    t.integer  "facebook_uid",      :null => false
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
