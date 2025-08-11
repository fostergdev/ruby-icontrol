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

ActiveRecord::Schema[8.0].define(version: 2025_08_10_172655) do
  create_table "ci_entries", force: :cascade do |t|
    t.text "content"
    t.date "date", null: false
    t.integer "ci_month_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ci_month_id"], name: "index_ci_entries_on_ci_month_id"
    t.index ["user_id"], name: "index_ci_entries_on_user_id"
  end

  create_table "ci_months", force: :cascade do |t|
    t.integer "month", null: false
    t.integer "year", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "month", "year"], name: "index_ci_months_on_user_id_and_month_and_year", unique: true
    t.index ["user_id"], name: "index_ci_months_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "name"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "ci_entries", "ci_months"
  add_foreign_key "ci_entries", "users"
  add_foreign_key "ci_months", "users"
  add_foreign_key "sessions", "users"
end
