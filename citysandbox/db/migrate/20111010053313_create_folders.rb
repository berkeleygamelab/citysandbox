class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.integer :user_id
      t.integer :parent_id
      t.string :name

      t.timestamps
    end
  end
end
