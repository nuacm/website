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

ActiveRecord::Schema.define(version: 20131002193732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dues", force: true do |t|
    t.integer  "amount"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "talker"
    t.string   "type"
  end

  create_table "keys", force: true do |t|
    t.string   "token"
    t.datetime "expires_on"
    t.boolean  "is_locked"
    t.integer  "keyable_id"
    t.string   "keyable_type"
    t.string   "key_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keys", ["token"], name: "index_keys_on_token", unique: true, using: :btree

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "password_digest"
  end

  add_index "members", ["email"], name: "index_members_on_email", unique: true, using: :btree

  create_table "members_positions", id: false, force: true do |t|
    t.integer "member_id"
    t.integer "position_id"
  end

  create_table "positions", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "member_type"
  end

  add_index "posts", ["member_id"], name: "index_posts_on_member_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
