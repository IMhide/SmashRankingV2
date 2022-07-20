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

ActiveRecord::Schema[6.1].define(version: 2021_10_03_125346) do

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

  create_table "matches", force: :cascade do |t|
    t.bigint "winner_id", null: false
    t.bigint "looser_id", null: false
    t.bigint "tournament_id", null: false
    t.integer "winner_score"
    t.integer "looser_score"
    t.datetime "completed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["looser_id"], name: "index_matches_on_looser_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "tournament_id"
    t.bigint "player_id"
    t.integer "placement", null: false
    t.integer "seed", null: false
    t.boolean "verified"
    t.boolean "dq"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_participations_on_player_id"
    t.index ["tournament_id"], name: "index_participations_on_tournament_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "team"
    t.string "remote_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "foreigner", default: false, null: false
  end

  create_table "rankings", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "compute_state"
    t.jsonb "standing"
    t.bigint "previous_season_id"
    t.jsonb "tmp_standing"
    t.index ["previous_season_id"], name: "index_rankings_on_previous_season_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "ranking_id", null: false
    t.bigint "player_id", null: false
    t.boolean "base", default: false, null: false
    t.decimal "mean", precision: 6, scale: 4, null: false
    t.decimal "deviation", precision: 6, scale: 4, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_ratings_on_match_id"
    t.index ["player_id"], name: "index_ratings_on_player_id"
    t.index ["ranking_id"], name: "index_ratings_on_ranking_id"
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
    t.bigint "ranking_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ranking_id"], name: "index_tier_lists_on_ranking_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.string "tournament_remote_id"
    t.string "event_remote_id"
    t.integer "remote_participant_count"
    t.bigint "ranking_id"
    t.datetime "dated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "match_sync"
    t.string "tier"
    t.index ["ranking_id"], name: "index_tournaments_on_ranking_id"
  end

  add_foreign_key "matches", "players", column: "looser_id"
  add_foreign_key "matches", "players", column: "winner_id"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "participations", "players"
  add_foreign_key "participations", "tournaments"
  add_foreign_key "rankings", "rankings", column: "previous_season_id"
  add_foreign_key "ratings", "matches"
  add_foreign_key "ratings", "players"
  add_foreign_key "ratings", "rankings"
  add_foreign_key "tier_lists", "rankings"
  add_foreign_key "tournaments", "rankings"
end
