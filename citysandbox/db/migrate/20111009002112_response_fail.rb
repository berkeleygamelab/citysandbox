class ResponseFail < ActiveRecord::Migration
  def up
        add_column :responses, :user_id, :integer
  end

  def down
  end
end
