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

ActiveRecord::Schema.define(version: 2021_01_07_213310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculations", force: :cascade do |t|
    t.string "fuel_type"
    t.integer "weight_in_kg"
    t.float "CO2_in_kg"
    t.float "SAF_in_kg"
    t.float "SAF_price_in_EUR"
    t.bigint "compensation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "offsetAPI_id"
    t.index ["compensation_id"], name: "index_calculations_on_compensation_id"
  end

  create_table "compensations", force: :cascade do |t|
    t.float "GFC_operational_fee_in_EUR"
    t.float "total_payable_price_in_EUR"
    t.boolean "toc_checked"
    t.boolean "newsletter_checked"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "calculations", "compensations"
end
