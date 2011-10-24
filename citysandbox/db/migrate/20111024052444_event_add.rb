class EventAdd < ActiveRecord::Migration
  def up
    add_column :events, :challenge_id, :integer
  end

  def down
  end
end
