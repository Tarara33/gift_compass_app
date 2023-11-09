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

ActiveRecord::Schema[7.0].define(version: 2023_11_09_030820) do
  create_table "item_tag_relations", force: :cascade do |t|
    t.integer "item_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "tag_id"], name: "index_item_tag_relations_on_item_id_and_tag_id", unique: true
    t.index ["item_id"], name: "index_item_tag_relations_on_item_id"
    t.index ["tag_id"], name: "index_item_tag_relations_on_tag_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "item_name", null: false
    t.string "item_image"
    t.string "item_url"
    t.integer "price", null: false
    t.integer "price_range", null: false
    t.integer "target_gender", null: false
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "icon"
    t.integer "role", default: 0, null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "item_tag_relations", "items"
  add_foreign_key "item_tag_relations", "tags"
  add_foreign_key "items", "users"
end
