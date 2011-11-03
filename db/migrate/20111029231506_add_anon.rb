class AddAnon < ActiveRecord::Migration
  def up
    drop_table :voting_tables
    add_column :voting_records, :proposal_id, :integer
  end

  def down
  end
end
