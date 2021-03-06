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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120904135826) do

  create_table "billing_addresses", :force => true do |t|
    t.integer  "client_id",       :null => false
    t.string   "postal_code",     :null => false
    t.string   "address_1",       :null => false
    t.string   "address_2"
    t.string   "address_3"
    t.string   "company_name"
    t.string   "recipient_name"
    t.string   "recipient_title"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "local_name"
    t.string   "accounting_code"
    t.integer  "user_id"
    t.text     "memo"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.integer  "client_id"
    t.string   "name"
    t.string   "email"
    t.string   "division"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "job_title"
  end

  create_table "payments", :force => true do |t|
    t.integer  "billing_address_id"
    t.date     "payment_deadline"
    t.date     "paid_on"
    t.integer  "closing_year"
    t.integer  "closing_month"
    t.text     "bill_to"
    t.text     "memo"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "product_types", :force => true do |t|
    t.string   "name"
    t.boolean  "expired"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.boolean  "includes_tax"
    t.integer  "product_type_id"
    t.boolean  "expired",         :default => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "identity"
  end

  create_table "work_order_products", :force => true do |t|
    t.integer "work_order_id",                       :null => false
    t.integer "product_id",                          :null => false
    t.integer "count"
    t.integer "fee"
    t.text    "memo"
    t.string  "schedule_unit"
    t.integer "schedule_count"
    t.date    "start_date"
    t.date    "end_date"
    t.boolean "is_fixed_schedule", :default => true
    t.integer "position"
  end

  create_table "work_orders", :force => true do |t|
    t.integer  "author_id"
    t.integer  "owner_id"
    t.integer  "client_id"
    t.text     "memo"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "payment_id"
    t.string   "status",     :default => "new"
  end

end
