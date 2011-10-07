 class Question < ActiveRecord::Base
  belongs_to :user
  has_many :challenges
  has_many :responses
  has_many :events
  has_many :followedquestions
  
  validates :user_id, :presence => true
  validates :title, :presence => true
  validates :location, :presence => true
  validates :x_coordinate, :presence => true
  validates :y_coordinate, :presence => true
  
end
