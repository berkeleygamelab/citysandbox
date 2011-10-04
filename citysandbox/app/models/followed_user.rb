class FollowedUser < ActiveRecord::Base
  has_a :user
  
  validates :user_id, :presence => true
  validates :followed_user_id, :presence => true
end
