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

ActiveRecord::Schema.define(version: 20161230082642) do

  create_table "attendance_managements", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "rest_hour",        limit: 4
    t.integer  "actual_work_hour", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "attendance_manegement_id", limit: 4
    t.string   "name",                     limit: 255
    t.datetime "start_time"
    t.datetime "extimate_end_time"
    t.datetime "actual_end_time"
    t.boolean  "finished_flag"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
