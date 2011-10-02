class MyNewMigration < ActiveRecord::Migration
  def up
    add_column :users, :password, :text, :null => false, :limit => 30, :default => "12345"
  end

  def down
  end
end
