class AdjustQuestions < ActiveRecord::Migration
  def up
    add_column :questions, :most_recent, :datetime, :default => Time.now
        add_column :challenges, :most_recent, :datetime, :default => Time.now
            add_column :events, :most_recent, :datetime, :default => Time.now
  end

  def down
  end
end
