class CreateResponses < ActiveRecord::Migration
  def up
    create_table :responses do |t|
      t.column :question_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :response, :text, :null => false, :limit => 1600
      t.timestamps
    end
  end
  def down
    drop_table :responses
  end
end
