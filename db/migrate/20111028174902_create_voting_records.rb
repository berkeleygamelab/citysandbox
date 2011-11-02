class CreateVotingRecords < ActiveRecord::Migration
  def change
    create_table :voting_records do |t|
      t.integer :user_id
      t.integer :vote, :null => false, :default => 0
      t.integer :voting_tables_id
      t.timestamps
    end
  end
end
