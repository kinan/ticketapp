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

ActiveRecord::Schema.define(:version => 20120410151431) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "priorities", :force => true do |t|
    t.string   "name"
    t.integer  "days"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams_users", :force => true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tickets", :force => true do |t|
    t.string   "subject"
    t.text     "description"
    t.string   "status"
    t.integer  "contact_id"
    t.integer  "creator_id"
    t.integer  "assignee_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.datetime "closed_at"
    t.integer  "team_id"
    t.integer  "priority_id"
  end

  add_index "tickets", ["assignee_id"], :name => "index_tickets_on_assignee_id"
  add_index "tickets", ["contact_id"], :name => "index_tickets_on_contact_id"
  add_index "tickets", ["creator_id"], :name => "index_tickets_on_creator_id"
  add_index "tickets", ["status"], :name => "index_tickets_on_status"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "group_id"
    t.string   "phone"
    t.text     "note"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "role"
    t.string   "name"
  end

  add_index "users", ["name"], :name => "index_users_on_name"

end
