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

ActiveRecord::Schema.define(version: 2023_10_12_172953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_categories", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_book_categories_on_book_id"
    t.index ["category_id"], name: "index_book_categories_on_category_id"
  end

  create_table "books", force: :cascade do |t|
    t.bigint "added_by_id", null: false
    t.bigint "responsible_id", null: false
    t.string "author"
    t.string "title"
    t.text "description"
    t.integer "status", default: 0
    t.string "isbn"
    t.string "publishing_company"
    t.string "publication_year"
    t.integer "language", default: 0
    t.integer "amount", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "negotiation_type", default: 0
    t.index ["added_by_id"], name: "index_books_on_added_by_id"
    t.index ["responsible_id"], name: "index_books_on_responsible_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chat_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_chat_users_on_chat_id"
    t.index ["user_id"], name: "index_chat_users_on_user_id"
  end

  create_table "chats", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorite_books", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "book_id"
    t.index ["book_id"], name: "index_favorite_books_on_book_id"
    t.index ["user_id"], name: "index_favorite_books_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.bigint "user_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
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

  create_table "trades", force: :cascade do |t|
    t.bigint "negotiator_id", null: false
    t.bigint "sender_id", null: false
    t.bigint "book_id", null: false
    t.integer "status", default: 0
    t.integer "category", default: 0
    t.date "negociation_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_trades_on_book_id"
    t.index ["negotiator_id"], name: "index_trades_on_negotiator_id"
    t.index ["sender_id"], name: "index_trades_on_sender_id"
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
    t.string "uuid", default: "44f767cb-a098-4a89-bd4e-d675429695c7", null: false
    t.index ["cpf_bidx"], name: "index_users_on_cpf_bidx", unique: true
    t.index ["email_bidx"], name: "index_users_on_email_bidx", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["phone_bidx"], name: "index_users_on_phone_bidx", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "book_categories", "books"
  add_foreign_key "book_categories", "categories"
  add_foreign_key "books", "users", column: "added_by_id"
  add_foreign_key "books", "users", column: "responsible_id"
  add_foreign_key "chat_users", "chats"
  add_foreign_key "chat_users", "users"
  add_foreign_key "favorite_books", "books"
  add_foreign_key "favorite_books", "users"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "ratings", "users", column: "evaluator_id"
  add_foreign_key "reports", "users", column: "reported_user_id"
  add_foreign_key "reports", "users", column: "reporter_id"
  add_foreign_key "trades", "books"
  add_foreign_key "trades", "users", column: "negotiator_id"
  add_foreign_key "trades", "users", column: "sender_id"
end
