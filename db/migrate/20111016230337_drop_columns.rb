class DropColumns < ActiveRecord::Migration
  def up
    remove_column :questions, :x_coordinate
    remove_column :questions, :y_coordinate
  end

  def down
  end
end
