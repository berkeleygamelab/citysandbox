class User < ActiveRecord::Base
  attr_accessible :login, :email, :password, :password_confirmation, :location
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :login, :email
  
  belongs_to :followed_question
  has_many :questions
  has_many :responses
  has_many :challenges
  has_many :events
  has_many :followed_users
  has_many :followed_challenges
  has_many :followed_questions
  has_many :followed_events
  has_many :response_challenges
  has_many :response_events
  has_many :response_questions
  has_many :messages
  has_many :message_copys
  has_many :voting_records
  has_many :proposals
 # before_create :build_inbox

   # def inbox
     # folders.find_by_name("Inbox")
   # end

    #def build_inbox
     # folders.build(:name => "Inbox")
  #  end

  validates :login, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true
  validates :location, :presence => true
  
  #has the given user link to this user
  def follow_this_user(follow_user)
    followed = FollowedUser.new(:followed_id => id, :user_id => follow_user.id)
    followed.save
  end
  
  def recent_activity
    stuff = []
    stuff += questions.order("updated_at DESC") + events.order("updated_at DESC") + challenges.order("updated_at DESC") + response_challenges.order("updated_at DESC") + response_questions.order("updated_at DESC") + response_events.order("updated_at DESC") + proposals.order("updated_at DESC")
    stuff.sort!{|a,b| b.updated_at<=> a.updated_at}
  end
  
  def limited_recent_activity(number)
    stuff = []
      stuff += questions.order("updated_at DESC").limit(number) + events.order("updated_at DESC").limit(number) + challenges.order("updated_at DESC").limit(number) + response_challenges.order("updated_at DESC").limit(number) 
      stuff += response_questions.order("updated_at DESC").limit(number) + response_events.order("updated_at DESC").limit(number) + proposals.order("updated_at DESC").limit(number)
      stuff.sort!{|a,b| b.updated_at <=> a.updated_at}
  end
  
  def my_followed
    stuff = []
    stuff += followed_questions + followed_events + followed_challenges + followed_users
  end
  
  
end
