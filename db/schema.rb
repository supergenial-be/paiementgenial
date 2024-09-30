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

ActiveRecord::Schema[7.2].define(version: 2024_09_30_112511) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "event_databases", force: :cascade do |t|
    t.string "name"
    t.string "notion_database_id"
    t.bigint "notion_workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notion_workspace_id"], name: "index_event_databases_on_notion_workspace_id"
  end

  create_table "notion_workspaces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from_email"
    t.string "from_name"
  end

  create_table "registration_databases", force: :cascade do |t|
    t.string "name"
    t.string "notion_database_id"
    t.bigint "notion_workspace_id", null: false
    t.bigint "event_database_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_database_id"], name: "index_registration_databases_on_event_database_id"
    t.index ["notion_workspace_id"], name: "index_registration_databases_on_notion_workspace_id"
  end

  create_table "registrations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "registration_database_id", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone"
    t.string "notion_event_id"
    t.integer "amount_cents"
    t.string "payment_status"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notion_database_item_id"
    t.string "notion_registration_database_id"
    t.index ["registration_database_id"], name: "index_registrations_on_registration_database_id"
  end

  add_foreign_key "event_databases", "notion_workspaces"
  add_foreign_key "registration_databases", "event_databases"
  add_foreign_key "registration_databases", "notion_workspaces"
  add_foreign_key "registrations", "registration_databases"
end
