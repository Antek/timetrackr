# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.integer  "group_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.integer  "group_id"
    t.string   "login"
    t.string   "fullname"
    t.string   "email"
    t.string   "full_name"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "timetracks", :force => true do |t|
    t.datetime "created_at"
    t.integer  "member_id"
    t.date     "date"
    t.string   "description"
    t.float    "hours_spent"
    t.integer  "label_id"
  end

end
