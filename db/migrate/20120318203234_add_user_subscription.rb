class AddUserFollowing < ActiveRecord::Migration
  def up
    puts "WHUT WHUT"
	create_table "user_subscriptions", :force => true do |t|
		t.integer "follower_id", :null=>false
		t.integer "followee_id", :null=>false
	end
	puts "IN THE BUTT"
  end

  def down
	drop_table "user_subscriptions"
  end
end
