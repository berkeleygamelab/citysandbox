class Followedusers < ActiveRecord::Base
  belongs_to :user
  
  validates :user_id, :presence => true
  validates :followed_user_id, :presence => true
end
