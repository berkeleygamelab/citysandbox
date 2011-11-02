class Rebuild < ActiveRecord::Migration
  def up
    create_table "challenges", :force => true do |t|
       t.integer  "question_id"
       t.text     "description",       :limit => 1600
       t.datetime "created_at"
       t.datetime "updated_at"
       t.string   "title"
       t.datetime "proposal_deadline"
       t.datetime "review_deadline"
       t.datetime "vote_deadline"
       t.integer  "user_id"
       t.integer  "x_coordinate"
       t.integer  "y_coordinate"
       t.string   "location"
     end

     create_table "events", :force => true do |t|
       t.datetime "created_at"
       t.datetime "updated_at"
       t.string   "title"
       t.integer  "user_id"
       t.integer  "x_coordinate"
       t.integer  "y_coordinate"
       t.string   "location"
     end

     create_table "folders", :force => true do |t|
       t.integer  "user_id"
       t.integer  "parent_id"
       t.string   "name"
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
     end

     create_table "questions", :force => true do |t|
       t.integer  "user_id"
       t.string   "title"
       t.string   "location",     :limit => 1600
       t.float    "x_coordinate", :limit => 64
       t.float    "y_coordinate", :limit => 64
       t.datetime "created_at"
       t.datetime "updated_at"
     end

     create_table "response_challenges", :force => true do |t|
       t.integer  "challenge_id",                 :null => false
       t.integer  "user_id",                      :null => false
       t.text     "response",     :limit => 1600, :null => false
       t.datetime "created_at"
       t.datetime "updated_at"
     end

     create_table "response_events", :force => true do |t|
       t.integer  "event_id",                   :null => false
       t.integer  "user_id",                    :null => false
       t.text     "response",   :limit => 1600, :null => false
       t.datetime "created_at"
       t.datetime "updated_at"
     end

     create_table "response_questions", :force => true do |t|
       t.integer  "question_id",                 :null => false
       t.integer  "user_id",                     :null => false
       t.text     "response",    :limit => 1600, :null => false
       t.datetime "created_at"
       t.datetime "updated_at"
     end

     create_table "responses", :force => true do |t|
       t.integer  "question_id",                 :null => false
       t.text     "response",    :limit => 1600, :null => false
       t.datetime "created_at"
       t.datetime "updated_at"
       t.integer  "user_id"
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

  def down
  end
end
