class CreateProposals < ActiveRecord::Migration
  def up
    create_table :proposals do |t|
      t.column :challenge_id, :integer, :null => false
      t.column :title, :text, :limit => 255, :null => false
      t.column :description, :text, :limit => 1600, :null => false
      t.column :rating, :integer, :null => false, :default => 0
      t.timestamps
    end
  end
  def down
    drop_table :proposals
  end
end
