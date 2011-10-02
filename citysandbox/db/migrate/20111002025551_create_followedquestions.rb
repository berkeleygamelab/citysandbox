class CreateFollowedquestions < ActiveRecord::Migration
  def change
    create_table :followedquestions do |t|
      t.column :question_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.timestamps
    end
  end
end
