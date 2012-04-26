class Zzz < ActiveRecord::Migration
  def up
    add_column :events, :threshold, :integer
  end


  def down
  end
end
