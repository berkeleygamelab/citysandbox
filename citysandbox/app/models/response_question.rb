class ResponseQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  
  validates :user_id, :presence => true
  validates :question_id, :presence => true
  validates :response, :presence => true
  
  after_save :update_time
  
  def update_time
    if id != nil
     question.updated_at = Time.now
     question.save
    end
  end
  
  
end
