# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_05_194442) do

  drop_table "matches" , if_exists: true
  drop_table "athletes" ,  if_exists: true
  drop_table "competitions", if_exists: true


  create_table "athletes", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string "nome"
    t.boolean "encerrada", default: true
    t.datetime "inicio", precision: 6
    t.datetime "fim", precision: 6
    t.boolean "tem_limite", default: false 
    t.integer "limite", default: 0, precision: 2
    t.string "ordenacao", precision: 3, default: 'ASC'
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "competition_id", null: false
    t.integer "athlete_id", null: false
    t.string "competicao", null: false
    t.string "atleta", null: false
    t.decimal "value", null: false
    t.string "unidade", precision: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["athlete_id"], name: "index_matches_on_athlete_id"
    t.index ["competition_id"], name: "index_matches_on_competition_id"
  end

  add_foreign_key "matches", "athletes"
  add_foreign_key "matches", "competitions"
end
