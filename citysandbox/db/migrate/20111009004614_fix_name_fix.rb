class FixNameFix < ActiveRecord::Migration
  def up
     rename_column :responses, :description, :response
     rename_column :challenges, :response, :description
  end

  def down
  end
end
