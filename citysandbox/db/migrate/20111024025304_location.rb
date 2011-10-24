class Location < ActiveRecord::Migration
  def up
    add_column :users, :location, :string
  end

  def down
  end
end
