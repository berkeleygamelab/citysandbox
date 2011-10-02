class AttachCategoryToQuestion < ActiveRecord::Migration
  def up
    add_column :users, :category, :text, :limit => 75, :null => false, :default => "other"
  end

  def down
  end
end
