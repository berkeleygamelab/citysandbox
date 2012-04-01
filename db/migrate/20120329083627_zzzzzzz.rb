class Zzzzzzz < ActiveRecord::Migration
  def up
  remove_column :item_templates, :type
  add_column :item_templates, :type, :string
  end

  def down
  end
end
