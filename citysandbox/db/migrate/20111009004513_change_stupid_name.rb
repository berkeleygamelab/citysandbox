class ChangeStupidName < ActiveRecord::Migration
  def up
     rename_column :responses, :response, :description
  end

  def down
  end
end
