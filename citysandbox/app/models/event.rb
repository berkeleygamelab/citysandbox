class Event < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :question
  belongs_to :user
  belongs_to :categories
  belongs_to :challenge
  
  has_many :response_events
  has_many :followed_events
  
  scope :followed, lambda{|key| {:conditions => {:id => key}}}
  
  scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
  scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}

  def category_id
     return categories_id
  end
   
   
  def create_followed(user)
     followed = FollowedEvent.new
     followed.user = user
     followed.event_id = id
     followed.save
  end

  
   
   
end
