class FixQuestions < ActiveRecord::Migration
  def up
    drop_table :responses
    create_table "questions", :force => true do |t|
      t.integer  "user_id"
      t.string   "title"
      t.string   "location",     :limit => 1600
      t.float    "x_coordinate", :limit => 64
      t.float    "y_coordinate", :limit => 64
      t.string   "category"
      t.datetime "updated_at"
    end
  end

  def down
  end
end
