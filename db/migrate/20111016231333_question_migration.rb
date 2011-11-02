class QuestionMigration < ActiveRecord::Migration
  def up
    add_column :questions, :anonymous, :integer, :default => 0
    remove_column :questions, :x_coordinate
    remove_column :questions, :y_coordinate
    add_column :proposals, :user_id, :integer
    add_column :questions, :category, :string
    add_column :response_questions, :anonymous, :integer, :default => 0
  end

  def down
  end
end
