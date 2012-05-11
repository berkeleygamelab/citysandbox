class DiscussionController < ApplicationController

def qr
  @url = params[:format]
  @title = params[:title]
  @response = {}
  @response['url'] = @url
  @response['title'] = @title
  return(@response)
end

respond_to :json

def summary
   filterNew
end


def filterNew

end


def filter

end

def sort_by_title(set, title)
  return set.has_title(title)
end

def sort_by_category(set, categoryList)

  return set.has_category(categoryList)
end

def sort_by_timestamp(set, num_days)
  timestamp = Time.now - num_days*60*60*24
  return set.where("updated_at > '#{timestamp}'")
end

def follow
  id = params[:item_to_follow]
  type = params[:type]
  add_follower(id, type)
  respond_with(true)
end

def unfollow
  id = params[:item_to_follow]
  type = params[:type]
  remove_follower(id, type)
  respond_with(true)
end

def sort_by_keyword(set, keyword)
  new_set = []
  keys = keyword.split
  keys.each do |wd|
    new_set = new_set | set.keyword(wd)
  end
  new_keys = []
  new_set.each do |thing|
    new_keys += [thing.id]
  end
  return set.followed(new_keys)
end

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
      item = User.where(:id => item_to_follow).first
  end
  item.create_followed(current_user)
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
        item = User.where(:id => item_to_follow).first
    end
    item.remove_followed(current_user)
end

def sort_descending(set)
  return set.order("id desc")
end

def display_following(set, type)
  followed_set_ids = []

  if type == "Question"
    followed_set = FollowedQuestion.where(:user_id => current_user.id)
  end
  if type == "Challenge"
    followed_set = FollowedChallenge.where(:user_id => current_user.id)
  end
  if type == "Event"
    followed_set = FollowedEvent.where(:user_id => current_user.id)
  end
  followed_set.each do |value|
    followed_set_ids += [value.followed_id]
  end

  return set.followed(followed_set_ids)

end

def sort_by_popularity(type, time, location)

  if type == "Question"
    dummy = Question.first
    popular_set = dummy.most_popular(time, 10000, location)
  end
  if type == "Challenge"
    dummy = Challenge.first
    popular_set = dummy.most_popular(time, 10000, location)
  end
  if type == "Event"
    dummy = Event.first
    popular_set = dummy.most_popular(time, 10000, location)
  end
end

def sort_by_location(distance, location, type, set)
  if type == "Question"
    dummy = Question.new

  end
  if type == "Challenge"
    dummy = Challenge.new

  end
  if type == "Event"
    dummy = Event.new

  end
  max_to_grab = 1000
  return dummy.sift_circle(distance, location, max_to_grab, set)
end

def sort_by_user(set, user)
  return set.where(:user_id => user)
end

end

