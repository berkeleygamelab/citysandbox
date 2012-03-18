class Challenge < ActiveRecord::Base
  has_many :proposals
  has_many :events
  has_one :item_template, :as => :item
  validates :submission_deadline, :presence => true
  validates :vote_deadline, :presence => true
  belongs_to :question
end

def category_id
	return item_template.cat_id
end

