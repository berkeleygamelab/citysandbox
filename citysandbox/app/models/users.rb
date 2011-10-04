class Users < ActiveRecord::Base
  belongs_to :followed_question
  has_many :questions
  has_many :responses
  has_many :followed_users
  
  validates :password, :presence => true
  validates :login, :presence => true
  validates :email, :presence => true
end
