class AddAnon < ActiveRecord::Migration
  def up
    drop_table :voting_tables
    
  end

  def down
  end
end
