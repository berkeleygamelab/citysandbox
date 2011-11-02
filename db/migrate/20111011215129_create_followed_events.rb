class CreateFollowedEvents < ActiveRecord::Migration
  def change
    create_table :followed_events do |t|
           t.integer  "user_id",          :null => false
           t.integer  "event_id", :null => false
           t.datetime "created_at"
           t.datetime "updated_at"
      t.timestamps
    end
  end
end
