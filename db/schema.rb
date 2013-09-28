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

ActiveRecord::Schema.define(:version => 20130928123614) do

  create_table "groups", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "description"
    t.string   "category"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "items", ["user_id"], :name => "index_items_on_user_id"

  create_table "reviews", :force => true do |t|
    t.string   "outcome"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reviews", ["task_id"], :name => "index_reviews_on_task_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "tasks", :force => true do |t|
    t.string   "description"
    t.string   "status"
    t.date     "due_date"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "tasks", ["user_id"], :name => "index_tasks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "UID"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["group_id"], :name => "index_users_on_group_id"

end
