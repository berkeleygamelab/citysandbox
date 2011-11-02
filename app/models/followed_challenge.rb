class FollowedChallenge < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :challenge_id, :presence => true
  
   
   def followed_id
     return challenge_id
   end
   
   
   after_save :upkeep
    after_create :upkeep
    before_destroy :destroy_upkeep

    def upkeep
      
      update_challenge_popularity


    end

    def update_challenge_popularity
      challenge.popularity += ENV['followed_value'].to_i
      challenge.save
    end


    def destroy_upkeep
      update_challenge_depopularity
    end

    def update_challenge_depopularity
      challenge.popularity -= ENV['followed_value'].to_i
      challenge.save
    end
  
  
end
