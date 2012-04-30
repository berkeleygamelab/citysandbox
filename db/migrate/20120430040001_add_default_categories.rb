class AddDefaultCategories < ActiveRecord::Migration
  def up
	Category.create(:category => "Public Space", :default_cat => true)
	Category.create(:category => "Health & Safety", :default_cat => true)
	Category.create(:category => "Transportation", :default_cat => true)
	Category.create(:category => "Dignity and Rights", :default_cat => true)
	Category.create(:category => "Education", :default_cat => true)
  end

  def down
  end
end
