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

ActiveRecord::Schema.define(version: 2020_11_25_092851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buy_process_inquiries", force: :cascade do |t|
    t.text "body"
    t.bigint "buy_process_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buy_process_id"], name: "index_buy_process_inquiries_on_buy_process_id"
  end

  create_table "buy_processes", force: :cascade do |t|
    t.datetime "successfully_closed_at"
    t.datetime "unsuccessfully_closed_at"
    t.string "source"
    t.bigint "user_id"
    t.bigint "client_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_buy_processes_on_client_id"
    t.index ["user_id"], name: "index_buy_processes_on_user_id"
  end

  create_table "car_intakes", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.bigint "car_sale_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_car_intakes_on_car_id"
    t.index ["car_sale_id"], name: "index_car_intakes_on_car_sale_id"
  end

  create_table "car_interest_inquiries", force: :cascade do |t|
    t.text "body"
    t.bigint "car_interest_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "tu_carro_question_id"
    t.index ["car_interest_id"], name: "index_car_interest_inquiries_on_car_interest_id"
    t.index ["created_at"], name: "index_car_interest_inquiries_on_created_at"
    t.index ["tu_carro_question_id"], name: "index_car_interest_inquiries_on_tu_carro_question_id"
  end

  create_table "car_interests", force: :cascade do |t|
    t.bigint "buy_process_id", null: false
    t.bigint "car_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buy_process_id"], name: "index_car_interests_on_buy_process_id"
    t.index ["car_id"], name: "index_car_interests_on_car_id"
    t.index ["car_intake_id"], name: "index_car_interests_on_car_intake_id"
  end

  create_table "car_sales", force: :cascade do |t|
    t.bigint "buy_process_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buy_process_id"], name: "index_car_sales_on_buy_process_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "description"
    t.string "tu_carro_id"
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "registration"
    t.index ["registration"], name: "index_cars_on_registration", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_at"], name: "index_clients_on_created_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "mercadolibre_api_access_tokens", force: :cascade do |t|
    t.text "access_token_ciphertext"
    t.text "refresh_token_ciphertext"
    t.datetime "expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.text "body"
    t.bigint "buy_process_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buy_process_id"], name: "index_notes_on_buy_process_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "role_grants", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_role_grants_on_role_id"
    t.index ["user_id", "role_id"], name: "index_role_grants_on_user_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_role_grants_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "code", null: false
    t.string "display_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_roles_on_code"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buy_process_inquiries", "buy_processes"
  add_foreign_key "buy_processes", "clients"
  add_foreign_key "buy_processes", "users"
  add_foreign_key "car_intakes", "car_sales"
  add_foreign_key "car_intakes", "cars"
  add_foreign_key "car_interest_inquiries", "car_interests"
  add_foreign_key "car_interests", "buy_processes"
  add_foreign_key "car_interests", "cars"
  add_foreign_key "car_sales", "buy_processes"
  add_foreign_key "notes", "buy_processes"
  add_foreign_key "notes", "users"
  add_foreign_key "role_grants", "roles"
  add_foreign_key "role_grants", "users"
end
