class RemoveCoordFromUsers < ActiveRecord::Migration
  def up
      remove_column :Users, :lng
      remove_column :Users, :lat
  end

  def down
      add_column :Users, :lng
      add_column :Users, :lat
  end
end
