class CreateMessageCopies < ActiveRecord::Migration
  def change
    create_table :message_copies do |t|
      t.integer :recipient_id
      t.integer :user_id 
      t.integer :folder_id

      t.timestamps
    end
  end
end
