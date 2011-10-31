class VotingRecord < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :proposal_id, :presence => true
  validate :proper_time
  
  def proper_time

    a= Time.now > proposal.challenge.vote_deadline
    if a
      errors.add(:proposal_id, "Too late to add the voting record")
    end
    return a
  end

  
 

end
