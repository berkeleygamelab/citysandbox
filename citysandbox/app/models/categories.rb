class Categories < ActiveRecord::Base
  has_many :questions
  has_many :events
  has_many :challenges
end
