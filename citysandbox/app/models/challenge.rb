class Challenge < ActiveRecord::Base
  has_many :proposals
  belongs_to :question
  
  validates :question_id, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
  validates :proposal_deadline, :presence => true
  validates :review_deadline, :presence => true
  validates :vote_deadline, :presence => true
end
