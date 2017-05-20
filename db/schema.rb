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

ActiveRecord::Schema.define(version: 20170520182502) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.bigint "link_id"
    t.string "content"
    t.datetime "extracted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_documents_on_link_id"
  end

  create_table "domain_services", force: :cascade do |t|
    t.string "domain_id"
    t.string "service_id"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.text "url"
    t.text "description"
    t.integer "search_depth"
    t.string "status", default: "active", null: false
    t.datetime "status_date"
    t.datetime "searched_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string "url"
    t.datetime "retrieved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_services", force: :cascade do |t|
    t.string "location_id"
    t.string "service_id"
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "county"
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "website"
    t.string "services"
    t.string "type_of_services"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "domain_id"
    t.string "latitude"
    t.string "longitude"
    t.index ["domain_id"], name: "index_locations_on_domain_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "number"
    t.string "kind"
    t.string "description"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "taxonomy_id"
    t.string "parent_id"
    t.string "parent_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "locations", "domains"
end
