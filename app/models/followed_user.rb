class FollowedUser < ActiveRecord::Base
  belongs_to :user
 

  def followed_user
    return User.where(:id => followed_user_id).first
  end
  
  def users_following(user)
    return FollowedUser.where(:followed_user_id => user.id)
  end
  def followed_users(user)
    return FollowedUser.where(:user_id => user.id)
  end
  
  validates :user_id, :presence => true
  validates :followed_user_id, :presence => true
end
