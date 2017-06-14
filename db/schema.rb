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

ActiveRecord::Schema.define(version: 20170614023312) do

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
    t.bigint "domain_id", null: false
    t.bigint "service_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_domain_services_on_domain_id"
    t.index ["service_id"], name: "index_domain_services_on_service_id"
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
    t.bigint "location_id", null: false
    t.bigint "service_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_location_services_on_location_id"
    t.index ["service_id"], name: "index_location_services_on_service_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "county"
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "website"
    t.string "service_description"
    t.string "type_of_services"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "latitude"
    t.string "longitude"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", default: "", null: false
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "domain_services", "domains"
  add_foreign_key "domain_services", "services"
  add_foreign_key "location_services", "locations"
  add_foreign_key "location_services", "services"
end
