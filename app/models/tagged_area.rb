class TaggedArea < ActiveRecord::Base
	has_many :groups, :through => :group_areas
	has_many :coordinates
#	has_many :users, :through => user_areas
end