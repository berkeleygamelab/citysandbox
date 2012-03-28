class TaggedArea < ActiveRecord::Base
	has_many :groups, :through => :group_areas
	has_many :coordinates, :foreign_key => "tagged_area_id"
#	has_many :users, :through => user_areas
end
