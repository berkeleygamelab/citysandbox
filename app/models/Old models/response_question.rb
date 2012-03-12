class ResponseQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  validates :user_id, :presence => true
  validates :question_id, :presence => true
  validates :response, :presence => true
  
  after_save :upkeep
  after_create :upkeep
  before_destroy :destroy_upkeep
  
  def upkeep
    update_time
    update_question_popularity
    
      
  end
    
  def update_question_popularity
    question.popularity += ENV['response_value'].to_i
    question.save
  end
  
  def update_time
    if id != nil
     question.updated_at = Time.now
     question.save
    end
  end
  
  def destroy_upkeep
    update_question_depopularity
  end
  
  def update_question_depopularity
    question.popularity -= ENV['response_value'].to_i
    question.save
  end
  
end
