class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def add_follower(item_to_follow, type)
    if type == "Question"
      item = Question.where(:id => item_to_follow).first
    end
    if type == "Challenge"
      item = Challenge.where(:id => item_to_follow).first
    end
    if type == "Event"
      item = Event.where(:id => item_to_follow).first
    end
    
    if type == "User"
      FollowedUser.create(:user_id => current_user.id, :followed_user_id => item_to_follow)
        else 
          item.create_followed(current_user)
    end
  end

  def remove_follower(item_to_follow, type)
      if type == "Question"
        item = Question.where(:id => item_to_follow).first
      end
      if type == "Challenge"
        item = Challenge.where(:id => item_to_follow).first
      end
      if type == "Event"
        item = Event.where(:id => item_to_follow).first
      end
       if type == "User"
          item = FollowedUser.where(:followed_user_id => item_to_follow).where(:user_id => current_user.id).first
          if item != nil
            item.remove
          end
        else 
              if item != nil
                item.remove_followed(current_user)
              end
          end
  end
  
  helper_method :add_follower
  helper_method :remove_follower
  
end
