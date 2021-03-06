# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100520152944) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.integer  "rate"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "url"
  end

  create_table "notes", :force => true do |t|
    t.integer  "project_id"
    t.integer  "client_id"
    t.integer  "user_id"
    t.integer  "rev"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content"
    t.integer  "panel_id"
  end

  create_table "panels", :force => true do |t|
    t.text     "title"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "css_name"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.date     "startdate"
    t.date     "duedate"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archive"
    t.integer  "user_id"
    t.text     "url"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
