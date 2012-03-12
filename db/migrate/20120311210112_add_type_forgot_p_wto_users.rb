class AddTypeForgotPWtoUsers < ActiveRecord::Migration
  def up
      add_column :Users, :type, :varchar(20)
      add_column :Users, :temp_pw, :integer
  end

  def down
      remove_column :Users, :type, :varchar(20)
      remove_column :Users, :temp_pw, :integer
  end
end
