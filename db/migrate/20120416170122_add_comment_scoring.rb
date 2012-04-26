class AddCommentScoring < ActiveRecord::Migration
  def up
	add_column :response_template, :score, :integer
  end
  def down
	drop_column :response_template, :score, :integer
  end
end
