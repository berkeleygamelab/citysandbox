class DiscussionController < ApplicationController

respond_to :json

def summary
  size_limit_questions = 15
  size_limit_discussion = 5
  page_offset = 0

  @collection_full = []
  @questions = Question.find(:all, :offset => page_offset * size_limit_questions, :limit =>size_limit_questions)
  @challenges = Challenge.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)
  @events = Event.find(:all, :offset => page_offset * size_limit_questions, :limit => size_limit_questions)

  @questions.each{|x| @collection_full = @collection_full +[[x,x.response_questions.limit(size_limit_discussion)]]}
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
  @timestamp = params[:timeBefore]
    
  @events = []
  @questions = []
  @challenges = []
  @followed = params[:following]
  @followed_type = params[:followed_type]  

  @keyword = params[:keyword]

  if (params[:follow] != nil)
      add_follower(params[:follow], params[:itemz])
  elsif (params[:unfollow] != nil) 
      remove_follower(params[:unfollow], params[:itemz])
  end

    if (@type_of_stuff == nil or @type_of_stuff.find_index("Questions") != nil)
      if @followed != nil
        @questions = display_following(Question, "Question")
        @flagsorted = true
      end
      if @title != nil
        @questions = sort_by_title(Question, @title)
        @flagsorted = true
      end
      if @category_type != nil
        @questions = sort_by_category(Question, @category_type)
        @flagsorted = true
      end
      if @timestamp != nil
        @questions = sort_by_timestamp(Question, @category_type)
        @flagsorted = true
      end
      if @keyword != nil
        @questions = sort_by_keyword(Question, @keyword)
        @flagsorted = true
      end
    end
    
    if (@type_of_stuff == nil or @type_of_stuff.find_index("Events") != nil)
      if @followed != nil
         @events = display_following(Event, "Event")
         @flagsorted = true
      end 
       if @title != nil
         @events = sort_by_title(Event, @title)
         @flagsorted = true
       end
       if @category_type != nil
         @events = sort_by_category(Event, @category_type)
         @flagsorted = true
       end
       if @timestamp != nil
         @events = sort_by_timestamp(Event, @category_type)
         @flagsorted = true
       end
       if @keyword != nil
          @events = sort_by_keyword(Event, @keyword)
          @flagsorted = true
        end
     end
     
     if(@type_of_stuff == nil or @type_of_stuff.find_index("Challenges") != nil)
         if @followed != nil
            @challenges = display_following(Challenge, "Challenge")
            @flagsorted = true
         end
        if @title != nil
          @challenges = sort_by_title(Challenge, @title)
          @flagsorted = true
        end
        if @category_type != nil
          @challenges = sort_by_category(Challenge, @category_type)
          @flagsorted = true
        end
        if @timestamp != nil
          @challenges = sort_by_timestamp(Challenge, @category_type)
          @flagsorted = true
        end
        if @keyword != nil
           @challenges = sort_by_keyword(Challenge, @keyword)
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
        if x.followed_questions.find_by_user_id(current_user.id) != nil 
          entry['followed'] = true
        else
          entry['followed'] = false
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
        if x.followed_challenges.find_by_user_id(current_user.id) != nil 
          entry['followed'] = true
        else
          entry['followed'] = false
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
        if x.followed_events.find_by_user_id(current_user.id) != nil 
          entry['followed'] = true
        else
          entry['followed'] = false
        end
        @collection = @collection + [entry]
      }
      
      @collection.sort!{|a,b| b['entry'].updated_at<=> a['entry'].updated_at}
      
      respond_with(@collection)

end

def sort_by_title(set, title)
  return set.has_title(title)
end

def sort_by_category(set, categoryList)
  
  return set.has_category(categoryList)
end

def sort_by_timestamp(set, timestamp)
  return set.where("updated_at <= ?", timestamp)
end

def sort_by_keyword(set, keyword)
  return set.keyword_sort(keyword)
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






end

