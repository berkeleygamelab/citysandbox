class QucikFixTable < ActiveRecord::Migration
  def up
    rename_column :message_copies, :recipient_id, :message_id
  end

  def down
  end
end
