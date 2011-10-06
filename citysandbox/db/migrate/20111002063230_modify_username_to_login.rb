class ModifyUsernameToLogin < ActiveRecord::Migration
  def up
    rename_column :users, :username, :login
    change_column :users, :login, :string
  end

  def down
    change_column :users, :login, :text
    rename_column :users, :login, :username
  end
end
