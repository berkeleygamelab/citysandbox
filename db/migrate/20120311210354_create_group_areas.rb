class CreateGroupAreas < ActiveRecord::Migration
  def change
    create_table :group_areas do |t|

      t.timestamps
    end
  end
end
