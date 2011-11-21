class DiscussionController < ApplicationController

def qr
  @url = params[:format]
  return(@url)
end

respond_to :json

def summary
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0

  @collection_full = []
  @questions = Question.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
  @challenges = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)

  @questions.each{|x| 
    num_events = 0
    x.challenges.each{|e| num_events += e.events.length }
    @collection_full = @collection_full +[[x,x.response_questions.limit(size_limit_discussion), num_events]]}
  @challenges.each{|x| @collection_full = @collection_full + [[x,x.response_challenges.limit(size_limit_discussion)]]}
  @events.each{|x| @collection_full = @collection_full + [[x, x.response_events.limit(size_limit_discussion)]]}

  @collection_full.sort!{|a,b| b[0].updated_at <=> a[0].updated_at}
  @collection_full.each{|x| x[1].sort!{|a,b| a.updated_at <=> b.updated_at}}
  
  current_page = 1
  if params[:page] != nil
    current_page = params[:page].to_i
  end
  per_page = 5
  
  @collection = WillPaginate::Collection.create(current_page, per_page, @collection_full.length) do |pager|
    start = (current_page-1)*per_page # assuming current_page is 1 based.
    pager.replace(@collection_full[start..(start+per_page)])
  end
  
  return(@collection)
end

def filter  
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0
  @collection = []
 
  @flagsorted = false 
  @category_type = params[:category]
  @type_of_stuff = params[:types]
  @title = params[:title]
  @days = params[:timeBefore]
    
  @events = []
  @questions = []
  @challenges = []
  @followed = params[:following]
  @followed_type = params[:followed_type]  
  @most_popular = params[:popular]
  @location_to_grab = params[:loc]
  dist = 10000
  if(@location_to_grab == nil)

    temp = Geocoder.coordinates(current_user.location)
    @location_to_grab = temp[0].to_s + " " + temp[1].to_s
  end
  @keyword = params[:keyword]

  if (params[:follow] != nil)
      add_follower(params[:follow], params[:itemz])
  elsif (params[:unfollow] != nil) 
      remove_follower(params[:unfollow], params[:itemz])
  end

    if (@type_of_stuff == nil or @type_of_stuff.find_index("Questions") != nil)
      @questions = Question
      if @most_popular != nil
        @questions = sort_by_popularity("Question", Time.now - 3600*30*24, @location_to_grab)
        @flagsorted = true
      end
      if @most_popular == nil
        @questions = sort_by_location(distance, @location_to_grab, "Question", @questions)
      end
      if @followed != nil
        @questions = display_following(@questions, "Question")
        @flagsorted = true
      end
      if @title != nil
        @questions = sort_by_title(@questions, @title)
        @flagsorted = true
      end
      if @category_type != nil
        @questions = sort_by_category(@questions, @category_type)
        @flagsorted = true
      end
      if @months != nil
        @questions = sort_by_timestamp(@questions, @months.to_i)
        @flagsorted = true
      end
      if @keyword != nil
        @questions = sort_by_keyword(@questions, @keyword)
        @flagsorted = true
      end
    end
    
    if (@type_of_stuff == nil or @type_of_stuff.find_index("Events") != nil)
      @events = Event
      if @most_popular != nil
        @events = sort_by_popularity("Event", Time.now - 3600*30*24, @location_to_grab)
        @flagsorted = true
      end
      if @most_popular == nil
        @questions = sort_by_location(distance, @location_to_grab, "Event", @events)
      end
      if @followed != nil
         @events = display_following(@events, "Event")
         @flagsorted = true
      end 
       if @title != nil
         @events = sort_by_title(@events, @title)
         @flagsorted = true
       end
       if @category_type != nil
         @events = sort_by_category(@events, @category_type)
         @flagsorted = true
       end
       if @months != nil
         @events = sort_by_timestamp(@events, @months.to_i)
         @flagsorted = true
       end
       if @keyword != nil
          @events = sort_by_keyword(@events, @keyword)
          @flagsorted = true
        end
     end
     
     if(@type_of_stuff == nil or @type_of_stuff.find_index("Challenges") != nil)
         @challenges = Challenge
         if @most_popular != nil
           @challenges = sort_by_popularity("Challenge", Time.now - 3600*30*24, @location_to_grab)
           @flagsorted = true
         end
         if @most_popular == nil
           @questions = sort_by_location(distance, @location_to_grab, "Challenge", @challenges)
         end
         if @followed != nil
            @challenges = display_following(@challenges, "Challenge")
            @flagsorted = true
         end
        if @title != nil
          @challenges = sort_by_title(@challenges, @title)
          @flagsorted = true
        end
        if @category_type != nil
          @challenges = sort_by_category(@challenges, @category_type)
          @flagsorted = true
        end
        if @months != nil
          @challenges = sort_by_timestamp(@challenges, @months.to_i)
          @flagsorted = true
        end
        if @keyword != nil
           @challenges = sort_by_keyword(@challenges, @keyword)
           @flagsorted = true
         end
      
      end
  
     if @flagsorted == false
       @questions = []
       @challenges = []
       @events = []
       if(@type_of_stuff.find_index("Questions") != nil or @type_of_stuff == nil)
         @questions = Question.find(:all)
       end
       if(@type_of_stuff.find_index("Challenges") != nil  or @type_of_stuff == nil)
         @challenges = Challenge.find(:all)
       end
       if(@type_of_stuff.find_index("Events") != nil  or @type_of_stuff == nil)
         @events = Event.find(:all)
       end
     end
     
      @collection = []
      @questions.each{ |x| 
        entry = {}
        entry['type'] = 'Question'
        entry['entry'] = x
        entry['created_at'] = x.created_at.strftime("%Y %b %d")
        entry['login'] = (x.anonymous == 1) ? nil : x.user.login
        if (x.response_questions.length > 0)
           entry['latest_response'] = (x.response_questions.last.response.length < 200) ? x.response_questions.last.response :
            (x.response_questions.last.response[0..200]  + '...')
        end
        entry_stats = {}
        entry_stats['Response'] = x.response_questions.length
        entry_stats['Follower'] = x.followed_questions.length
        entry_stats['Challenge'] = x.challenges.length
        entry['address'] = x.location
        num_events = 0
        x.challenges.each { |challenge| 
          num_events += challenge.events.length
        }
        entry_stats['Event'] = num_events
        entry['stats'] = entry_stats
        entry['id'] = x.id
        entry['category'] = Categories.find(x.categories_id).category
        entry['url'] = question_url(x)
        if current_user != nil 
          entry['current_user'] = current_user.login
          if x.followed_questions.find_by_user_id(current_user.id) != nil 
            entry['followed'] = true
          else
            entry['followed'] = false
          end
        end
        @collection = @collection + [entry]
      }
      @challenges.each{ |x|
        entry = {}
        entry['type'] = 'Challenge'
        entry['entry'] = x
        entry['login'] = x.user.login     
        entry['created_at'] = x.created_at.strftime("%Y %b %d")
        entry['submission_deadline'] = x.submission_deadline.strftime("%Y %b %d")
        entry['vote_deadline'] = x.vote_deadline.strftime("%Y %b %d")
        entry['description'] = (x.description.length > 200) ? x.description[0..200] + '...' : x.description;
        entry_stats = {}
        entry_stats['Response'] = x.response_challenges.length
        entry_stats['Follower'] = x.followed_challenges.length
        entry_stats['Proposal'] = x.proposals.length
        entry_stats['Event'] = x.events.length
        entry['stats'] = entry_stats
        entry['id'] = x.id
        entry['address'] = x.location
        entry['category'] = Categories.find(x.categories_id).category
        entry['url'] = challenge_url(x)
        if current_user != nil 
          entry['current_user'] = current_user.login
          if x.followed_challenges.find_by_user_id(current_user.id) != nil 
            entry['followed'] = true
          else
            entry['followed'] = false
          end
        end
        @collection = @collection + [entry]
      }
      @events.each{|x|
        entry = {}
        entry['type'] = 'Event'
        entry['entry'] = x
        entry['login'] = x.user.login
        entry['created_at'] = x.created_at.strftime("%Y %b %d")
        entry['date'] = x.time.strftime("%Y %b %d")
        entry_stats = {}
        entry_stats['Response'] = x.response_events.length
        entry_stats['Follower'] = x.followed_events.length
        entry['stats'] = entry_stats
        entry['id'] = x.id
        entry['address'] = x.location
        entry['category'] = Categories.find(x.categories_id).category
        entry['url'] = event_url(x)
        if current_user != nil 
          entry['current_user'] = current_user.login
          if x.followed_events.find_by_user_id(current_user.id) != nil 
            entry['followed'] = true
          else
            entry['followed'] = false
          end
        end
        @collection = @collection + [entry]
      }
      
      @collection.sort!{|a,b| b['entry'].updated_at <=> a['entry'].updated_at}
      
      respond_with(@collection)
end

def sort_by_title(set, title)
  return set.has_title(title)
end

def sort_by_category(set, categoryList)
  
  return set.has_category(categoryList)
end

def sort_by_timestamp(set, num_days)
  timestamp = Time.now - num_days*60*60*24
  return set.where("updated_at > ?", timestamp)
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
    dummy = Question.first

  end
  if type == "Challenge"
    dummy = Challenge.first

  end
  if type == "Event"
    dummy = Event.first
   
  end
  max_to_grab = 1000
  return dummy.sift_circle(distance, location, max_to_grab, set)
end


end

