class Message < ActiveRecord::Base

  belongs_to :user, :class_name => "User"
  has_many :message_copys
  has_many :recipients, :through => :message_copies
 
  validates :subject, :presence => true
  validates :body, :presence => true
  

  
end
