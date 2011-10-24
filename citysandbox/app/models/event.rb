class Event < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  belongs_to :categories
  belongs_to :challenge
  
  has_many :response_events
  has_many :followed_events
  
  scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
  scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}

  def category_id
     return categories_id
   end
   
   
end
