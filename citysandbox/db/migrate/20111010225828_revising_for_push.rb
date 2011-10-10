class RevisingForPush < ActiveRecord::Migration
  def up
    drop_table :followedusers
    drop_table :followedquestions
    remove_column :users, :category
    remove_column :questions, :description 
    add_column :challenges, :x_coordinate, :integer
    add_column :challenges, :y_coordinate, :integer
    add_column :events, :x_coordinate, :integer
    add_column :events, :y_coordinate, :integer
  end

  def down
  end
end
