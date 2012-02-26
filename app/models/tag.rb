class Tag < ActiveRecord::Base
	attr_accessor :tag_type #1=question, 2=group, 3=challenge, 4=event
	has_many :questions
	has_many :groups
	has_many :challenges
	has_many :events
	
	def insert_item(type,id,cat_id)
		
	
	def return_item(type,id)
		case type:
			when 1
				return Question.where(:question_id => id)
			when 2
				return Group.where(:group_id => id)
			when 3
				return Challenge.where(:challenge_id => id)
			when 4
				return Event.where(:event_id => id)
		end
			
	def count_number_cats(cat_id)
		return Tag.where(:category_id => cat_id).count
	
	def count_number_cats_txt(cat_name)
		id = text_to_id(cat_name)
		return Tag.count_number_cats(id)
	
	def return_localized_popular(location, tag_id, distance)
		h = Hash.new
		closeQ = ::FT.execure "SELECT * FROM Questions WHERE ST_INTERSECTS(Location, CIRCLE(location,distance)")
		qTags = Tag.where(:type => 1)
		gTags = Tag.where(:type => 2)
		cTags = Tag.where(:type => 3)
		eTags = Tag.where(:type => 4)
		qTags.each do |qTag|
			if h[qTag.cat_id].nil? and qTag.questions.where(::FT.execute "SELECT * FROM #{@events_table} WHERE ST_INTERSECTS(Location, CIRCLE(LATLNG(#{@loc_x}, #{@loc_y}), #{distance})) AND Origin = 'events'"
:
				h[qTag.cat_id] = qTag.popularity
		gTags.each do |gTag|
			
				
			
		
			
	
	
	
	
	
	
end





end
