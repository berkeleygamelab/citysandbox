 class Question < ActiveRecord::Base
  belongs_to :user
  has_many :challenges
  has_many :response_questions
  has_many :events
  has_many :followedquestions
  
  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :location, :presence => true

  
end
