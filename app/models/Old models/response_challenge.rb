class ResponseChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  
  validates :user_id, :presence => true
  validates :challenge_id, :presence => true
  validates :response, :presence => true
  
  after_save :upkeep
  after_create :upkeep
  before_destroy :destroy_upkeep
  
  def upkeep
    update_time
    update_challenge_popularity
    
      
  end
    
  def update_challenge_popularity
    challenge.popularity += ENV['response_value'].to_i.to_i
    challenge.save
  end
  
  def update_time
    if id != nil
     challenge.updated_at = Time.now
     challenge.save
    end
  end
  
  def destroy_upkeep
    update_challenge_depopularity
  end
  
  def update_challenge_depopularity
    challenge.popularity -= ENV['response_value'].to_i.to_i
    challenge.save
  end
  
end
