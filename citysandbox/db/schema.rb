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

ActiveRecord::Schema.define(:version => 20111017002439) do

  create_table "categories", :force => true do |t|
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "challenges", :force => true do |t|
    t.integer  "question_id"
    t.text     "description",         :limit => 1600
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.datetime "submission_deadline"
    t.datetime "vote_deadline"
    t.integer  "user_id"
    t.string   "location"
    t.integer  "category_id"
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "user_id"
    t.string   "location"
    t.string   "description"
    t.datetime "time"
    t.integer  "category_id"
  end

  create_table "folders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followed_challenges", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "challenge_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followed_events", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "event_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followed_questions", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "question_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followed_users", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "followed_user_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_copies", :force => true do |t|
    t.integer  "message_id"
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.integer  "challenge_id",                                :null => false
    t.text     "title",        :limit => 255,                 :null => false
    t.text     "description",  :limit => 1600,                :null => false
    t.integer  "rating",                       :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "location",    :limit => 1600
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "anonymous",                   :default => 0
    t.string   "description"
    t.integer  "category_id"
  end

  create_table "response_challenges", :force => true do |t|
    t.integer  "challenge_id",                                :null => false
    t.integer  "user_id",                                     :null => false
    t.text     "response",     :limit => 1600,                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "anonymous",                    :default => 0
  end

  create_table "response_events", :force => true do |t|
    t.integer  "event_id",                                  :null => false
    t.integer  "user_id",                                   :null => false
    t.text     "response",   :limit => 1600,                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "anonymous",                  :default => 0
  end

  create_table "response_questions", :force => true do |t|
    t.integer  "question_id",                                :null => false
    t.integer  "user_id",                                    :null => false
    t.text     "response",    :limit => 1600,                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "anonymous",                   :default => 0
  end

  create_table "users", :force => true do |t|
    t.text     "login",           :limit => 75,                   :null => false
    t.text     "picture",         :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email",           :limit => 75,  :default => " ", :null => false
    t.string   "password_digest"
  end

end
