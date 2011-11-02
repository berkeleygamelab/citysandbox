class ReviseName < ActiveRecord::Migration
  def up
    rename_column :questions, :category_id, :categories_id
    rename_column :events, :category_id, :categories_id
    rename_column :challenges, :category_id, :categories_id
  end

  def down
  end
end
