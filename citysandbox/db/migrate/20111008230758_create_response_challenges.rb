class CreateResponseChallenges < ActiveRecord::Migration
  def up
    create_table :response_challenges do |t|
      t.column :challenge_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :response, :text, :null => false, :limit => 1600

      t.timestamps
    end
  end
end
