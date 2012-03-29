class Meh < ActiveRecord::Migration
  def up
  add_column :challenges, :voting_deadline, :datetime
  add_column :challenges, :submission_deadline, :datetime
  end

  def down
  end
end
