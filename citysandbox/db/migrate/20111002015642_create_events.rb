class CreateEvents < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.timestamps
    end
  end
  def down
    drop_table :events
  end
end