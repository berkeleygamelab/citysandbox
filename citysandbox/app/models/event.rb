class Event < ActiveRecord::Base
  belongs_to :question
  has_many :response_events
  
end
