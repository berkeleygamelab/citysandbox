class ReceivedMessage < ActiveRecord::Base
	belongs_to :folder
	belongs_to :sent_message
	belongs_to :recipient, :polymorphic => true
end