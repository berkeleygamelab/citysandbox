class CategoryEntries < ActiveRecord::Migration
  def up
    add_column :questions, :description, :string
    Categories.create :category => "commerce"
    Categories.create :category => "dignity&rights"
    Categories.create :category => "history"
    Categories.create :category => "kids&education"
    Categories.create :category => "public space"
    Categories.create :category => "transportation"
          
  end

  def down
  end
end
