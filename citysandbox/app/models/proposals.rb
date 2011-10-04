class Proposals < ActiveRecord::Base
  belongs_to :challenge
  
  validates :challenge_id, :presence => true
  validates :title, :presence => true
end
