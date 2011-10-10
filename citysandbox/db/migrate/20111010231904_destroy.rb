class Destroy < ActiveRecord::Migration
  def up
    drop_table :challenges
    drop_table :events
    drop_table :folders
    drop_table :followed_questions
    drop_table :followed_users
    drop_table :messages
    drop_table :message_copies
    drop_table :proposals
    drop_table :questions
    drop_table :response_challenges
    drop_table :response_questions
    drop_table :response_events
    drop_table :responses
    drop_table :users

    
  end

  def down
  end
end
