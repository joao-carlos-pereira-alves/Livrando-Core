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

ActiveRecord::Schema.define(version: 2023_08_26_223652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.bigint "added_by_id", null: false
    t.bigint "responsible_id", null: false
    t.string "author"
    t.string "title"
    t.text "description"
    t.integer "status", default: 0
    t.integer "genre", default: 0
    t.string "isbn"
    t.string "publishing_company"
    t.string "publication_year"
    t.integer "language", default: 0
    t.integer "amount", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["added_by_id"], name: "index_books_on_added_by_id"
    t.index ["responsible_id"], name: "index_books_on_responsible_id"
  end

  create_table "favorite_books", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_favorite_books_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rating"
    t.text "comment"
    t.bigint "evaluator_id", null: false
    t.string "evaluable_type"
    t.bigint "evaluable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evaluable_type", "evaluable_id"], name: "index_ratings_on_evaluable"
    t.index ["evaluator_id"], name: "index_ratings_on_evaluator_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "reporter_id", null: false
    t.bigint "reported_user_id", null: false
    t.integer "reason", default: 0
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reported_user_id"], name: "index_reports_on_reported_user_id"
    t.index ["reporter_id"], name: "index_reports_on_reporter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_ciphertext", default: "", null: false
    t.string "email_bidx"
    t.string "cpf_ciphertext", default: "", null: false
    t.string "cpf_bidx"
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.date "birth_date"
    t.string "phone_ciphertext", default: "", null: false
    t.string "phone_bidx"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jti", null: false
    t.integer "status", default: 0
    t.integer "report_count", default: 0
    t.index ["cpf_bidx"], name: "index_users_on_cpf_bidx", unique: true
    t.index ["email_bidx"], name: "index_users_on_email_bidx", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["phone_bidx"], name: "index_users_on_phone_bidx", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "users", column: "added_by_id"
  add_foreign_key "books", "users", column: "responsible_id"
  add_foreign_key "favorite_books", "users"
  add_foreign_key "ratings", "users", column: "evaluator_id"
  add_foreign_key "reports", "users", column: "reported_user_id"
  add_foreign_key "reports", "users", column: "reporter_id"
end
