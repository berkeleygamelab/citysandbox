class ModifyUsernameToLogin < ActiveRecord::Migration
  def up
       rename_column :users, :username, :login
  end

  def down
  end
end
