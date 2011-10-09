class CreateResponseEvents < ActiveRecord::Migration
  def up
    create_table :response_events do |t|
      t.column :event_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :response, :text, :null => false, :limit => 1600

      t.timestamps
    end
  end
end
