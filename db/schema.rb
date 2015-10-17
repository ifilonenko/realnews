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

ActiveRecord::Schema.define(version: 20151017232222) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "endorses", force: :cascade do |t|
    t.integer  "endorser_id"
    t.integer  "endorsed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text     "description"
    t.boolean  "is_deleted"
    t.string   "image_url"
    t.string   "player_type"
    t.string   "player_embed"
    t.integer  "like_count"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "session_code"
    t.string   "ip_address"
    t.boolean  "is_active"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "full_name"
    t.string   "bio"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "num_endorsements"
    t.integer  "num_posts"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
