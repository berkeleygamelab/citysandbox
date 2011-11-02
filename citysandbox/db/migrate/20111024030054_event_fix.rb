class EventFix < ActiveRecord::Migration
  def up
    add_column :events, :question_id, :integer
  end

  def down
  end
end
