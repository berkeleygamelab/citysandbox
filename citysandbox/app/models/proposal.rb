class Proposal < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  has_many :voting_records
  
  validates :challenge_id, :presence => true
  validates :title, :presence => true
 
  
  def total
     return voting_records.sum(:vote)
   end
  
  
  
end
