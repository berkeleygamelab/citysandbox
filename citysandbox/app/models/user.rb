class User < ActiveRecord::Base
  attr_accessible :login, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :login, :email
  
  belongs_to :followed_question
  has_many :questions
  has_many :responses
  has_many :followed_users

  validates :login, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true

end
