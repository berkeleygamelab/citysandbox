class VotingRecord < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :proposal_id, :presence => true
  validate :proper_time
  
  def proper_time
    dummy = Proposal.where(:id => proposal_id).first
    a = true
    if dummy != nil
      a= Time.now > dummy.challenge.vote_deadline
    end
    if a
      errors.add(:proposal_id, "Too late to add the voting record")
    end
    return a
  end

  
 

end
