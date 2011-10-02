class CreateQuestions < ActiveRecord::Migration	

  def up
    create_table :questions do |t|
      t.column :user_id, :integer, :null => false
      t.column :title, :string, :limit=>255, :null => false
      t.column :description, :string, :limit=>1600, :null => false
      t.column :location, :string, :limit=>1600, :null
      t.column :x_coordinate, :float, :limit=>64, :null => false
      t.column :y_coordinate, :float, :limit=>64, :null => false
      t.timestamps
    end
  end
  def down
    drop_table :questions
  end
end
