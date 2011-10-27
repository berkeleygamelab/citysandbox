class FollowedQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  validates_uniqueness_of :user_id
  
  validates :question_id, :presence => true
  validates :user_id, :presence => true
  
  def followed_id
    return question_id
  end
end
