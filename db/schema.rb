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

ActiveRecord::Schema.define(version: 2021_07_24_021722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bikes", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "image_name", null: false
    t.decimal "price_per_day", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_bikes_on_name", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "bike_id"
    t.datetime "date", null: false
    t.string "user_full_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.integer "status", default: 0
    t.index ["bike_id"], name: "index_bookings_on_bike_id"
    t.index ["date", "bike_id"], name: "index_bike_date_on_active_bookings", unique: true, where: "(status = 0)"
    t.index ["status"], name: "index_bookings_on_status"
    t.index ["type"], name: "index_bookings_on_type"
  end

  add_foreign_key "bookings", "bikes"
end
