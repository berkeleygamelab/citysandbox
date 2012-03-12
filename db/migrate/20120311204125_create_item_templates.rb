class CreateItemTemplates < ActiveRecord::Migration
  def change
    create_table :item_templates do |t|

      t.timestamps
    end
  end
end
