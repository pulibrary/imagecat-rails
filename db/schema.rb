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

ActiveRecord::Schema[8.0].define(version: 2023_10_19_192939) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "card_images", force: :cascade do |t|
    t.text "path"
    t.text "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_name"], name: "index_card_images_on_image_name", unique: true
  end

  create_table "guide_cards", force: :cascade do |t|
    t.string "heading"
    t.string "sortid"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "info_cards", force: :cascade do |t|
    t.string "path"
    t.text "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_guide_cards", force: :cascade do |t|
    t.string "heading"
    t.string "sortid"
    t.string "parentid"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
