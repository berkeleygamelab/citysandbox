class FollowedChallenge < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :challenge_id, :presence => true
  
   
   def followed_id
     return challenge_id
   end
   
  
  
end
