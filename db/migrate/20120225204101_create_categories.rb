class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
	  t.integer "cat_id"
	  t.text "cat_name"
	  t.integer "popularity"
	  t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
	
	
end
