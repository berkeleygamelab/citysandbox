class User < ActiveRecord::Base

  attr_accessible :login, :email, :password, :password_confirmation, :location, :lng, :lat, :img, :temp_pwd, :picture
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :login, :email
 
  
#  belongs_to :followed_question

#  has_many :questions
#  has_many :responses
#  has_many :challenges
#  has_many :events
#  has_many :followed_users
#  has_many :followed_challenges
#  has_many :followed_questions
#  has_many :followed_events
#  has_many :response_challenges
#  has_many :response_events
#  has_many :response_questions
#  has_many :messages
#  has_many :message_copys
#  has_many :voting_records
#  has_many :proposals

 # before_create :build_inbox

   # def inbox
     # folders.find_by_name("Inbox")
   # end

    #def build_inbox
     # folders.build(:name => "Inbox")
  #  end

  #double check return value of open and picture URL
  def render_image(user)
      if user.picture != nil || user.picture != "DEFAULT"
         return Fleakr.resource_from_url(user.picture, 'rb') 	
      end
  end

  def upload_image(user, uploaded_file)
    name =  uploaded_file.original_filename
        
    #create the file path
    path = File.join("tmp", name)

    # write the file
    File.open(path, "wb") { |f| f.write(uploaded_file.read) }
        
    item = Fleakr.upload(path)
    user.picture = "DEFAULT"
    if item != nil && item[0] != nil
        user.picture = item[0].url
    end
    
  end

  validates :login, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true
  validates :location, :presence => true
  #validate :name_check

  
  after_create :send_confirmation
  
  def name_check
    if(login.strip != login)
      errors.add(:login, "login can't start or end with blank spaces")
    end
    if(login.split.size != 1)
      errors.add(:login, "login can't have any spaces in it")
    end
  end
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
  
  #links the follow_user TO this user
  def create_followed(follow_user)
    followed = FollowedUser.new(:user_id => follow_user.id, :followed_user_id => id)
    followed.save
  end
  
  def remove_followed(follow_user)
    followed = FollowedUser.where(:followed_user_id => id).where(:user_id => follow_user.id).first
    if followed != nil
      followed.destroy
    end
  end
  

  
  
  def send_confirmation
    temp_pwd = :temp_pwd
    mail = UserMailer.signup_notification(self, self.temp_pwd)
    mail.deliver
  end
  
  
  
end
