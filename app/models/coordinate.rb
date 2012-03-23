class Coordinate < ActiveRecord::Base
	belongs_to :tagged_area, :foreign_key => "tagged area_id"
end
