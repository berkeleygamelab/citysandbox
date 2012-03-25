
class RemoveQmark < ActiveRecord::Migration
  def up
	#remove_column :sent_messages, :anonymous?
	remove_column :response_templates, :anonymous?
	#remove_column :response_templates, "group response"
	#remove_column :sent_messages, "group message?"
	#remove_column :received_messages, :read?
	#remove_column :questions, :anonymous?
	#remove_column :notifications, :seen?
	remove_column :coordinates, "tagged area_id"
	
	add_column :sent_messages, :anonymous
	add_column :response_templates, :anonymous
	add_column :response_templates, :group_response
	add_column :sent_messages, :group_message
	add_column :received_messages, :read
	add_column :questions, :anonymous
	add_column :notifications, :seen
	add_column :coordinates, :tagged_area_id
  end

  def down
	remove_column :sent_message, :anonymous, :boolean
	remove_column :response_template, :anonymous, :boolean
	remove_column :response_template, :group_response, :boolean
	remove_column :sent_message, :group_message, :boolean
	remove_column :received_message, :read, :boolean
	remove_column :question, :anonymous, :boolean
	remove_column :notification, :seen, :boolean
	
	add_column :sent_message, :anonymous?
	add_column :response_template, :anonymous?
	add_column :response_template, :group_response?
	add_column :sent_message, :group_message?
	add_column :received_message, :read?
	add_column :question, :anonymous?
	add_column :notification, :seen?
  end
end
