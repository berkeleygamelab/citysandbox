class Event < ActiveRecord::Base
  belongs_to :question
  has_many :response_events
  has_many :followed_events
  
end
