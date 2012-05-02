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

end


def filterNew

 size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0
  @collection = []
  @flagsort = false
  @cat_id = params[:category] # it's an integer
  @startDate = params[:timeBefore]
  @endDate = params[:timeAfter]
  @types = params[:types] #array of strings that specifies what type of item we're filtering for; names like question, challenge, event
  if @endDate==nil
    @endDate = Time.now
  end
  @events = []

  @questions = []
  @challenges = []
  @location_to_grab = params[:loc]
  @target_user = params[:by_user]
  @radius = params[:radius]
  @following = params[:following]
  @popular = params[:popular]
  
  
  @default_categories = Category.where(:default_cat => true)
  @my_categories = []
  @popular_categories = []
  @my_areas = []
  
  
  if(@location_to_grab == nil)
    if !current_user.nil?

      @location_to_grab = params[:location]
      @my_categories = current_user.categories
    end
    if current_user.nil?
      @error = "ERROR"

      return nil
    else
      @location_to_grab = current_user.location
    end
  end
  temp = Geocoder.coordinates(@location_to_grab)
  @location_to_grab = temp[0].to_s + " " + temp[1].to_s
  @keyword = params[:keyword]
  if @types == nil
    @types = ["Question","Challenge","Event"]
  end 
  @dummy = ItemTemplate.new
  if @radius == nil
    @radius = 25000
  end
  @items = @dummy.grab_circle(@radius, @location_to_grab, @types)
  @collection = []
  @items.each do |hash|
    if !@types.include?(hash['Type'])
      @items.delete(hash)
      next
      end
    if !@cat_id.nil? and !(hash['Category']==@cat_id)
      @items.delete(hash)
      next
    end
    currentItem = ItemTemplate.find_by_id(hash['Id'])
    currentContentHash = currentItem.generate_content
    if !(currentContentHash["created_at"]>@startDate and currentContentHash["crated_at"]<@endDate)
      @items.delete(hash)
      next
      end
    if !(currentContentHash["popularity"]>@popular)
      @items.delete(hash)
      next
      end
    if !(currentContentHash["title"].include? @keyword or currentContentHash["description"].include? @keyword)
      @items.delete(hash)
      next
      end
    @collection = @collection + [currentContentHash]
 end
  return @collection

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

