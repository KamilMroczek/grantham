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

ActiveRecord::Schema.define(version: 20140303003510) do

  create_table "projects", force: true do |t|
    t.string   "title",      limit: 50,                  null: false
    t.string   "logline",    limit: 300,                 null: false
    t.date     "start_date",                             null: false
    t.boolean  "approved",               default: false
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "skills", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "skill_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_skills", ["skill_id"], name: "index_user_skills_on_skill_id"
  add_index "user_skills", ["user_id"], name: "index_user_skills_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",      limit: 256, null: false
    t.string   "imdb",       limit: 256
    t.string   "website",    limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
