class Proposal < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  has_many :voting_records
  
  validates :challenge_id, :presence => true
  validates :title, :presence => true
  validate :prior_deadline
  
  def total
     return voting_records.size
   end
  
  def prior_deadline
    if Time.now > challenge.submission_deadline
      errors.add(:challenge_id, "Past proposal submission deadline")
    end
  end
  
  
end
