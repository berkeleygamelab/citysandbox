class AddEmailToName < ActiveRecord::Migration
  def up
    add_column :users, :email, :string, :limit => 75, :null => false, :default => ""
  end

  def down
    remove_column :users, :email
  end
end
