class User < ActiveRecord::Base
  attr_accessible :login, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :login, :email
  
  belongs_to :followed_question
  has_many :questions
  has_many :responses
  has_many :followed_users
  has_many :followed_challenges
  has_many :followed_questions
  has_many :followed_events
  has_many :response_challenges
  has_many :response_events
  has_many :response_questions
  has_many :messages
  has_many :message_copys
  
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

end
