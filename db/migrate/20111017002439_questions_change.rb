class QuestionsChange < ActiveRecord::Migration
  def up
    remove_column :questions, :category
    add_column :questions, :category_id, :integer
    remove_column :challenges, :category
    add_column :challenges, :category_id, :integer
    remove_column :events, :category
    add_column :events, :category_id, :integer 
    
  end

  def down
  end
end
