class FollowedEvent < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :event_id, :presence => true
  
  
  def followed_id
    return event_id
  end
  
  
  after_save :upkeep
   after_create :upkeep
   before_destroy :destroy_upkeep

   def upkeep
     update_event_popularity


   end

   def update_event_popularity
     event.popularity += ENV['FOLLOWED_VALUE']
     event.save
   end

  
   def destroy_upkeep
     update_event_depopularity
   end

   def update_event_depopularity
     event.popularity -= ENV['FOLLOWED_VALUE']
     event.save
   end
  
end
