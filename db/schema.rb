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

ActiveRecord::Schema.define(version: 20140130061848) do

  create_table "positions", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_positions", force: true do |t|
    t.integer  "project_id",  null: false
    t.integer  "position_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "title",                                null: false
    t.string   "logline",                  limit: 140, null: false
    t.text     "description"
    t.date     "start_date",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_image_file_name"
    t.string   "cover_image_content_type"
    t.integer  "cover_image_file_size"
    t.datetime "cover_image_updated_at"
  end

  create_table "signups", force: true do |t|
    t.string   "email",      limit: 256,                 null: false
    t.string   "imdb",       limit: 256
    t.string   "website",    limit: 256
    t.boolean  "approved",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "signups", ["email"], name: "index_signups_on_email", unique: true

  create_table "users", force: true do |t|
    t.string   "email",      limit: 256, null: false
    t.string   "imdb",       limit: 256
    t.string   "website",    limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
