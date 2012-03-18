class AddUserFollowing < ActiveRecord::Migration
  def up
	create_table "user_subscriptions", :force => true do |t|
		t.integer "follower_id", :null=>false
		t.integer "followee_id", :null=>false
  end

  def down
	drop_table "user_subscriptions"
  end
end
