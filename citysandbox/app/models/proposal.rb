class Proposal < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  
  validates :challenge_id, :presence => true
  validates :title, :presence => true
end
