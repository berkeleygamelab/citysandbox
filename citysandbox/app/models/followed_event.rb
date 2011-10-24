class FollowedEvent < ActiveRecord::Base
  belongs_to :events
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :event_id, :presence => true
  
  
  def followed_id
    return event_id
  end
  
end
