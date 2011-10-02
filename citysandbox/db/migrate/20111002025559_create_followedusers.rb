class CreateFollowedusers < ActiveRecord::Migration
  def change
    create_table :followedusers do |t|
      t.column :user_id, :integer, :null => false
      t.column :followed_user_id, :integer, :null => false
      t.timestamps
    end
  end
end
