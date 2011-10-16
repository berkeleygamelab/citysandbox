class FlagGenerator < ActiveRecord::Migration
  def up
    add_column :users, :anonymous, :integer, :default => 0
    
  end

  def down
  end
end
