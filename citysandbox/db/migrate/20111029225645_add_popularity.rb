class AddPopularity < ActiveRecord::Migration
  def up
    add_column :questions, :popularity, :double
    add_column :challenges, :popularity, :double
    add_column :events, :popularity, :double
  end

  def down
  end
end
