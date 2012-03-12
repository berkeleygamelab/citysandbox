class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :login, :email
  has_many :tagged_areas, :through => :user_areas
#  has_many :categories, :through => user_category
#  has_many :notifications, :through => user_category
  has_many :sent_messages
  has_many :received_messages, :as => :recipient
  has_many :folders
  has_many :groups, :through => :memberships
  has_many :response_templates, :as => :responder
  
  validates :login, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true
  validates :location, :presence => true
  
  def name_check
    if(login.strip != login)
      errors.add(:login, "login can't start or end with blank spaces")
    end
    if(login.split.size != 1)
      errors.add(:login, "login can't have any spaces in it")
    end
  end
  
  def follow_this_user(follow_user)
    subscription = FollowedUser.new(:followed_id => id, :user_id => follow_user.id)
    followed.save
  end
  
end