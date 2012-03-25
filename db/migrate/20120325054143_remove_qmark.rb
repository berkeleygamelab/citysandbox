
class removeQmark < ActiveRecord::Migration
  def up
	remove_column :sent_message, :anonymous?
	remove_column :response_template, :anonymous?
	remove_column :response_template, :group_response?
	remove_column :sent_message, :group_message?
	remove_column :received_message, :read?
	remove_column :question, :anonymous?
	remove_column :notification, :seen?
	
	add_column :sent_message, :anonymous
	add_column :response_template, :anonymous
	add_column :response_template, :group_response
	add_column :sent_message, :group_message
	add_column :received_message, :read
	add_column :question, :anonymous
	add_column :notification, :seen
  end

  def down
	remove_column :sent_message, :anonymous
	remove_column :response_template, :anonymous
	remove_column :response_template, :group_response
	remove_column :sent_message, :group_message
	remove_column :received_message, :read
	remove_column :question, :anonymous
	remove_column :notification, :seen
	
	add_column :sent_message, :anonymous?
	add_column :response_template, :anonymous?
	add_column :response_template, :group_response?
	add_column :sent_message, :group_message?
	add_column :received_message, :read?
	add_column :question, :anonymous?
	add_column :notification, :seen?
  end
end
