class ResponseEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  
  validates :user_id, :presence => true
  validates :event_id, :presence => true
  
  after_save :upkeep
  after_create :upkeep
  before_destroy :destroy_upkeep
  
  def upkeep
    update_time
    update_event_popularity
    
      
  end
    
  def update_event_popularity
    event.popularity += ENV['response_value'].to_i.to_i
    event.save
  end
  
  def update_time
    if id != nil
     event.updated_at = Time.now
     event.save
    end
  end
  
  def destroy_upkeep
    update_event_depopularity
  end
  
  def update_event_depopularity
    event.popularity -= ENV['response_value'].to_i.to_i
    event.save
  end
  
end
