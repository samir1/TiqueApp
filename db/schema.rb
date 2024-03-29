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

ActiveRecord::Schema.define(version: 20170124165928) do

  create_table "codes", force: :cascade do |t|
    t.integer  "owner",                        null: false
    t.string   "code_value",                   null: false
    t.string   "title",                        null: false
    t.string   "code_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "code_type",  default: "class", null: false
    t.string   "ta_emails"
  end

  create_table "critiques", force: :cascade do |t|
    t.string   "comment",                   null: false
    t.integer  "votes",      default: 0,    null: false
    t.integer  "author_id"
    t.string   "code_value"
    t.boolean  "positive",   default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "instructor_student_lookups", force: :cascade do |t|
    t.string   "code_value"
    t.integer  "student_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "isTA",       default: false
  end

  create_table "tas", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "code_value", null: false
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fname",           null: false
    t.string   "lname",           null: false
    t.string   "email"
    t.string   "password_digest", null: false
    t.string   "salt"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id",    null: false
    t.integer  "critique_id", null: false
    t.boolean  "upvote",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
