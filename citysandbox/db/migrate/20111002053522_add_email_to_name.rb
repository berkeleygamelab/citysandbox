class AddEmailToName < ActiveRecord::Migration
  def up
    add_column :users, :email, :text, :limit => 75, :null => false, :default => " "
  end

  def down
  end
end
