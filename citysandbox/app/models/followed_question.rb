class FollowedQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
 
  
  validates :question_id, :presence => true
  validates :user_id, :presence => true
  
  
  
  
  def followed_id
    return question_id
  end
  
  after_save :upkeep
   after_create :upkeep
   before_destroy :destroy_upkeep

   def upkeep
     update_question_popularity


   end

   def update_question_popularity
     question.popularity += ENV['followed_value'].to_i
     question.save
   end

   

   def destroy_upkeep
     update_question_depopularity
   end

   def update_question_depopularity
     question.popularity -= ENV['followed_value'].to_i
     question.save
   end
  
end
