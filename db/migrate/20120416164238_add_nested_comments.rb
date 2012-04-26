class AddNestedComments < ActiveRecord::Migration
  def up
	add_column :response_template, :lft, :integer
	add_column :response_template, :rgt, :integer
	add_column :response_template, :depth, :integer
  end

  def down
	drop_column :response_template, :lft, :integer
	drop_column :response_template, :rgt, :integer
	drop_column :response_template, :depth, :integer
  end
end
