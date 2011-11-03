class RemoveVotingPower < ActiveRecord::Migration
  def up
    remove_column :voting_records, :voting_table_id
    remove_column :voting_records, :vote
  end

  def down
  end
end
