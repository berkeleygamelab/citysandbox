class Newsetbaby < ActiveRecord::Migration
  def up
    add_column :questions, :category, :string
    add_column :challenges, :category, :string
    add_column :events, :category, :string
  end

  def down
  end
end
