class TestSet < ActiveRecord::Migration
  def up
    add_column :challenges, :location, :string
    add_column :events, :location, :string
  end

  def down
  end
end
