class ChangeStupidNmae < ActiveRecord::Migration
  def up
    rename_column :response, :description
  end

  def down
  end
end
