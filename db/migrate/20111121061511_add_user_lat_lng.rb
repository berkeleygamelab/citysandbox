class AddUserLatLng < ActiveRecord::Migration
  def up
    add_column :users, :lat, :string
    add_column :users, :lng, :string
  end

  def down
  end
end
