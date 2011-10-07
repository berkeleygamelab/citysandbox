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

ActiveRecord::Schema.define(:version => 20111007214337) do

  create_table "challenges", :force => true do |t|
    t.integer  "question_id"
    t.text     "response",    :limit => 1600
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
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

  create_table "followedquestions", :force => true do |t|
    t.integer  "question_id", :null => false
    t.integer  "user_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followedusers", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "followed_user_id", :null => false
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
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description",  :limit => 1600
    t.string   "location",     :limit => 1600
    t.float    "x_coordinate", :limit => 64
    t.float    "y_coordinate", :limit => 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.integer  "question_id",                 :null => false
    t.text     "response",    :limit => 1600, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.text     "login",           :limit => 75,                       :null => false
    t.text     "picture",         :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "email",           :limit => 75,  :default => " ",     :null => false
    t.text     "category",        :limit => 75,  :default => "other", :null => false
    t.string   "password_digest"
  end

end
