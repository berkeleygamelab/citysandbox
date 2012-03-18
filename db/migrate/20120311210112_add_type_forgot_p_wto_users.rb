class AddTypeForgotPWtoUsers < ActiveRecord::Migration
  def up
      add_column :users, :type, :varchar(20)
      add_column :users, :temp_pw, :integer
  end

  def down
      remove_column :users, :type, :varchar(20)
      remove_column :users, :temp_pw, :integer
  end
end
