# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_03_131701) do
  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
  end

  create_table "stays", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "room", default: "Small Double"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id", null: false
    t.text "description"
    t.index ["room_id"], name: "index_stays_on_room_id"
    t.index ["user_id"], name: "index_stays_on_user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "priority", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "description"
    t.boolean "status", default: false
    t.datetime "completed_at"
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "stays", "rooms"
  add_foreign_key "stays", "users"
  add_foreign_key "todos", "users"
end
