class FollowedUser < ActiveRecord::Base
  belongs_to :user

  def followed_user()
    return User.where(:id => followed_user_id)[0]
  end
  
  validates :user_id, :presence => true
  validates :followed_user_id, :presence => true
end
