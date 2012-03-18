class ItemTemplate < ActiveRecord::Base
	belongs_to :item, :polymorphic => true
	belongs_to :category, :foreign_key => "cat_id"
	has_many :notification
	has_many :users, :through => :subscriptions	
	has_many :response_templates
	validates :user_id, :presence => true
    validates :title, :presence => true
    validates :location, :presence => true 
	scope :followed, lambda{|key| {:conditions => {:id => key}}}
	scope :has_category,       lambda{ |n| { :conditions => { :categories_id => n}}}
	scope :has_title, lambda{|name| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ?", "% " + name + " %", name, name + " %"]}}
	scope :keyword, lambda{|key| {:conditions => ["title LIKE ? OR title LIKE ? OR title LIKE ? OR description LIKE ? OR description LIKE ? OR description LIKE ?", "% " + key + " %", key, key + " %", "% " + key + " %", key, key + " %" ]}}
	
	def category_id
      return cat_id
	end
	
	def create_followed(follower)
		followed = subscription.new
		followed.user_id = follower.id
		followed.item_template_id = item_template.id
		if subscription.where(:item_template_id=> id).where(:user_id => follower.id) == []
			followed.save
		end
	end
	
	def most_popular(since_last, types)
		return item_template.find(:all, :conditions => ["updated_at > ? AND type IN (?)", since_last, types]).where()
    end
	
	
end
