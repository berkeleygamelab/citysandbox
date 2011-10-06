class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.column :username, :text, :null => false, :limit => 75
      t.column :password, :text, :null => false, :limit => 30
   
      t.column :picture, :text, :limit => 255
      t.column :start, :datetime
      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
