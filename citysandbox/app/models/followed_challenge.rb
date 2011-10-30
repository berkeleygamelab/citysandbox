class FollowedChallenge < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  validates_uniqueness_of :user_id
  
  validates :user_id, :presence => true
  validates :challenge_id, :presence => true
  
   
   def followed_id
     return challenge_id
   end
   
  
  
end
