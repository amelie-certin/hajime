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

ActiveRecord::Schema.define(version: 20170917153529) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "arms"
    t.integer "legs"
    t.integer "strength"
    t.integer "defense"
    t.integer "health"
    t.integer "focus"
    t.integer "speed"
    t.integer "charisma"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "characters_weapons", force: :cascade do |t|
    t.integer "weapon_id"
    t.integer "character_id"
    t.index ["character_id"], name: "index_characters_weapons_on_character_id"
    t.index ["weapon_id"], name: "index_characters_weapons_on_weapon_id"
  end

  create_table "fights", force: :cascade do |t|
    t.integer "winner"
    t.integer "player_id"
    t.integer "opponent_id"
    t.index ["opponent_id"], name: "index_fights_on_opponent_id"
    t.index ["player_id"], name: "index_fights_on_player_id"
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.integer "arms"
    t.integer "legs"
    t.integer "focus"
    t.integer "power"
  end

end
