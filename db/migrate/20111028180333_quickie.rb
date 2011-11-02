class Quickie < ActiveRecord::Migration
  def up
    rename_column :voting_records, :voting_tables_id, :voting_table_id
  end

  def down
  end
end
