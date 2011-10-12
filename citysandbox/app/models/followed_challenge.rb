class FollowedChallenge < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :question_id, :presence => true
end
