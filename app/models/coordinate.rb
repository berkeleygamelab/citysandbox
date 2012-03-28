class Coordinate < ActiveRecord::Base
	belongs_to :tagged_area, :foreign_key => "tagged_area_id"
end
