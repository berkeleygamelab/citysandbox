class CreateChallenges < ActiveRecord::Migration
  def up
    create_table :challenges do |t|
      t.column :question_id, :integer
      t.column :title, :text, :limit => 255, :null => false
      t.column :description, :text, :limit => 1600, :null => false
      t.column :proposal_deadline, :datetime, :null => false
      t.column :review_deadline, :timestamp, :null
      t.column :vote_deadline, :timestamp, :null => false
      t.timestamps
    end
  end
  def down
    drop_table :challenges
  end
end
