class CreateFollowedChallenges < ActiveRecord::Migration
  def change
    create_table :followed_challenges do |t|
           t.integer  "user_id",          :null => false
           t.integer  "challenge_id", :null => false
           t.datetime "created_at"
           t.datetime "updated_at"
      t.timestamps
    end
  end
end
