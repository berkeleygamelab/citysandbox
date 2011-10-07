class FixingStartPosition < ActiveRecord::Migration
  def up
    remove_column :users, :start
  end

  def down
  end
end
