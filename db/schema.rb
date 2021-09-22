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

ActiveRecord::Schema.define(version: 2021_09_21_142348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.integer "card_id"
    t.boolean "user_attack"
    t.boolean "gym_leader_attack"
    t.integer "hp"
    t.integer "damage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "battles_gym_leaders", id: false, force: :cascade do |t|
    t.bigint "battle_id", null: false
    t.bigint "gym_leader_id", null: false
  end

  create_table "battles_users", id: false, force: :cascade do |t|
    t.bigint "battle_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "pokemon_type"
    t.string "ability"
    t.integer "hp"
    t.integer "attack"
    t.string "img_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cards_gym_leaders", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "gym_leader_id", null: false
  end

  create_table "cards_users", id: false, force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "gym_leaders", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "winrate", default: 0, null: false
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
