class FollowedQuestion < ActiveRecord::Base
  has_a: user
  has_a: question
  
  validates :question_id, :presence => true
  validates :user_id, :presence => true
end
