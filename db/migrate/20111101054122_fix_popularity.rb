class FixPopularity < ActiveRecord::Migration
  def up
    remove_column :challenges, :popularity
        remove_column :events, :popularity
            remove_column :questions, :popularity
    add_column  :challenges, :popularity, :integer, :default => 0
    add_column  :questions, :popularity, :integer, :default => 0
    add_column  :events, :popularity, :integer, :default => 0
  end

  def down
  end
end
