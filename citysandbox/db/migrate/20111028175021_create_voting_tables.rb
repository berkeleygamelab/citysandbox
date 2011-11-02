class CreateVotingTables < ActiveRecord::Migration
  def change
    create_table :voting_tables do |t|
      t.integer :proposal_id
      t.timestamps
    end
  end
end
