# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141008233202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "households", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
  end

  create_table "households_users", force: true do |t|
    t.integer "user_id"
    t.integer "household_id"
  end

  create_table "transactions", force: true do |t|
    t.integer  "from_user_id"
    t.integer  "to_user_id"
    t.integer  "household_id"
    t.decimal  "amount",       precision: 8, scale: 2
    t.boolean  "confirmed",                            default: false
    t.boolean  "is_bill",                              default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["from_user_id"], name: "index_transactions_on_from_user_id", using: :btree
  add_index "transactions", ["household_id"], name: "index_transactions_on_household_id", using: :btree
  add_index "transactions", ["to_user_id"], name: "index_transactions_on_to_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
