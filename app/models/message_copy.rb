class MessageCopy < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  belongs_to :folder

  validate :user_id, :presence => true
  validate :message_id, :presence => true
  
end
