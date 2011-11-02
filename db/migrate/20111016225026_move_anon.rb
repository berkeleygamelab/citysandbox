class MoveAnon < ActiveRecord::Migration
  def up
    remove_column :users, :anonymous
    add_column :questions, :anonymous, :integer, :default => 0
    add_column :responses, :anonymous, :integer, :default => 0
    add_column :response_challenges, :anonymous, :integer, :default => 0
    add_column :response_events, :anonymous, :integer, :default => 0
    drop_table :questions
  end

  def down
  end
end
