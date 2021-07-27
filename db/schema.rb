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

ActiveRecord::Schema.define(version: 2021_07_27_143448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "rankings", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tier_lists", force: :cascade do |t|
    t.integer "ss_min", null: false
    t.float "ss_coef", null: false
    t.integer "s_min", null: false
    t.float "s_coef", null: false
    t.integer "a_min", null: false
    t.float "a_coef", null: false
    t.integer "b_min", null: false
    t.float "b_coef", null: false
    t.integer "c_min", null: false
    t.float "c_coef", null: false
    t.bigint "rankings_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rankings_id"], name: "index_tier_lists_on_rankings_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "tournament_remote_id"
    t.string "event_remote_id"
    t.integer "remote_participant_count"
    t.bigint "rankings_id"
    t.datetime "dated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rankings_id"], name: "index_tournaments_on_rankings_id"
  end

  add_foreign_key "tier_lists", "rankings", column: "rankings_id"
  add_foreign_key "tournaments", "rankings", column: "rankings_id"
end
