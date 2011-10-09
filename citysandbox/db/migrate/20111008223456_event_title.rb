class EventTitle < ActiveRecord::Migration
  def up
        add_column :events, :title, :string
  end

  def down
  end
end
