class Challenge < ActiveRecord::Base
  has_many :proposals
  has_many :response_challenges
  belongs_to :question
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :proposal_deadline, :presence => true
  validates :review_deadline, :presence => true
  validates :vote_deadline, :presence => true
end
