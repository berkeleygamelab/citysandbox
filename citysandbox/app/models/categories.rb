class Categories < ActiveRecord::Base
  belongs_to :question
  belongs_to :event
  belongs_to :challenge
end
