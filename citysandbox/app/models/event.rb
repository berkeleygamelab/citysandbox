class Event < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_one :categories
  
  has_many :response_events
  has_many :followed_events
  
end
