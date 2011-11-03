class ReStabilize < ActiveRecord::Migration
  def up
    drop_table :questions
     create_table "questions", :force => true do |t|
       t.integer  "user_id"
       t.string   "title"
       t.string   "location",     :limit => 1600
       t.float    "x_coordinate", :limit => 64
       t.float    "y_coordinate", :limit => 64
       t.datetime "created_at"
       t.datetime "updated_at"
     end
  end

  def down
  end
end
