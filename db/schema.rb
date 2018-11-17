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

ActiveRecord::Schema.define(version: 2018_11_17_224736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inc_fiat_accounts", force: :cascade do |t|
    t.string "currency_code"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bank"
  end

  create_table "inc_stable_accounts", force: :cascade do |t|
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.float "amount_fiat"
    t.float "amount_stable"
    t.float "exchange_rate"
    t.string "currency_code"
    t.bigint "inc_fiat_account_id"
    t.bigint "inc_stable_account_id"
    t.bigint "user_stable_account_id"
    t.bigint "user_fiat_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "typetr"
    t.index ["inc_fiat_account_id"], name: "index_transactions_on_inc_fiat_account_id"
    t.index ["inc_stable_account_id"], name: "index_transactions_on_inc_stable_account_id"
    t.index ["user_fiat_account_id"], name: "index_transactions_on_user_fiat_account_id"
    t.index ["user_stable_account_id"], name: "index_transactions_on_user_stable_account_id"
  end

  create_table "user_fiat_accounts", force: :cascade do |t|
    t.string "currency_code"
    t.float "amount"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_fiat_accounts_on_user_id"
  end

  create_table "user_stable_accounts", force: :cascade do |t|
    t.float "amount"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_stable_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "currency_pref"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "transactions", "inc_fiat_accounts"
  add_foreign_key "transactions", "inc_stable_accounts"
  add_foreign_key "transactions", "user_fiat_accounts"
  add_foreign_key "transactions", "user_stable_accounts"
  add_foreign_key "user_fiat_accounts", "users"
  add_foreign_key "user_stable_accounts", "users"
end
