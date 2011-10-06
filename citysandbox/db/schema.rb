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

ActiveRecord::Schema.define(:version => 20111002063230) do

  create_table "challenges", :force => true do |t|
    t.integer  "question_id"
    t.text     "title",             :limit => 255,  :null => false
    t.text     "description",       :limit => 1600, :null => false
    t.datetime "proposal_deadline",                 :null => false
    t.datetime "review_deadline",                   :null => false
    t.datetime "vote_deadline",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
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
    t.integer  "user_id",                      :null => false
    t.string   "title",                        :null => false
    t.string   "description",  :limit => 1600, :null => false
    t.string   "location",     :limit => 1600, :null => false
    t.float    "x_coordinate", :limit => 64,   :null => false
    t.float    "y_coordinate", :limit => 64,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", :force => true do |t|
    t.integer  "question_id",                 :null => false
    t.integer  "user_id",                     :null => false
    t.text     "response",    :limit => 1600, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",           :limit => 75,                       :null => false
    t.text     "picture",         :limit => 255
    t.datetime "start"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email",           :limit => 75,  :default => "",      :null => false
    t.string   "category",        :limit => 75,  :default => "other", :null => false
  end

end
