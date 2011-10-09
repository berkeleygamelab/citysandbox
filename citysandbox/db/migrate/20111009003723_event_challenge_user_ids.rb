class EventChallengeUserIds < ActiveRecord::Migration
  def up
     add_column :events, :user_id, :integer
     add_column :challenges, :user_id, :integer
  end

  def down
  end
end
