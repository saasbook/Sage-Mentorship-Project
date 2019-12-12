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

ActiveRecord::Schema.define(version: 2019_12_02_032443) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_admins_on_school_id"
  end

  create_table "checkins", force: :cascade do |t|
    t.datetime "checkin_time"
    t.string "checkin_lat"
    t.string "checkin_lon"
    t.integer "mentor_id"
    t.integer "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "date"
    t.boolean "isValid"
    t.index ["mentor_id"], name: "index_checkins_on_mentor_id"
    t.index ["school_id"], name: "index_checkins_on_school_id"
  end

  create_table "checkouts", force: :cascade do |t|
    t.datetime "checkout_time"
    t.string "checkout_lat"
    t.string "checkout_lon"
    t.integer "mentor_id"
    t.integer "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ischeckout"
    t.string "date"
    t.boolean "isValid"
    t.index ["mentor_id"], name: "index_checkouts_on_mentor_id"
    t.index ["school_id"], name: "index_checkouts_on_school_id"
  end

  create_table "mentors", force: :cascade do |t|
    t.string "name"
    t.integer "school_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_mentors_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
