class MessageCopy < ActiveRecord::Base
  belongs_to :user
  belongs_to :message
  belongs_to :folder

  
end
