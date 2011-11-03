class Killcoordinates < ActiveRecord::Migration
  def up
    remove_column :challenges, :x_coordinate
    remove_column :challenges, :y_coordinate
    remove_column :events, :x_coordinate
    remove_column :events, :y_coordinate
    remove_column :questions, :x_coordinate
    remove_column :questions, :y_coordinate
    remove_column :challenges, :review_deadline
    rename_column :challenges, :proposal_deadline, :submission_deadline
    add_column :events, :description, :string
    add_column :events, :time, :datetime 

  end

  def down
  end
end
