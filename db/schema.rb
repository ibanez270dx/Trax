# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140614011208) do

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_tracks", force: true do |t|
    t.integer "tag_id"
    t.integer "track_id"
  end

  create_table "tracks", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "audio_file_name"
    t.string   "audio_file_size"
    t.string   "audio_content_type"
    t.string   "audio_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
