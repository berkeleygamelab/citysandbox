class AttachCategoryToQuestion < ActiveRecord::Migration
  def up
    add_column :users, :category, :string, :limit => 75, :null => false, :default => "other"
  end

  def down
    remove_column :users, :category
  end
end
