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

ActiveRecord::Schema.define(version: 2019_03_26_151002) do

  create_table "applications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.string "description"
    t.string "company"
    t.string "job_type"
    t.string "github_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "favorite_language"
  end

end
