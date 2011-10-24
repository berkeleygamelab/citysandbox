class Challenge < ActiveRecord::Base
  has_many :proposals
  has_many :response_challenges
  has_many :followed_challenges
  has_many :events
  
  belongs_to :question
  belongs_to :user
  belongs_to :categories
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :submission_deadline, :presence => true
  validates :vote_deadline, :presence => true
  
  scope :followed, lambda{|key| {:conditions => {:id => key}}}
  
  scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
  scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}


  def category_id
     return categories_id
   end
   
   def create_followed(user)
     followed = FollowedChallenge.new
     followed.user = user
     followed.challenge_id = id
     followed.save
   end

   
end
