class Category < ActiveRecord::Base
	has_many :item_templates, :through =>:categoryholders
	validates :name, :presence => true
	attr_accessor :cat_id
	validates_uniqueness_of :name
	has_many :users, :through => :user_categories
	
	def get_n_popular_cats(n)
		return Category.find(:order => 'popularity', :limit => n)
	end
	

	def auto_fill(text)
		cats = Category.find(:all, :conditions => ['name LIKE ?', text + '%'])
		results = []
		cats.each do |cat| 
			results += [cat.name]
		return results
	end
	end	
	
	def return_cat_id(text)
		cat = Category.where(:name => text)
		if cat is nil
			return nil
		end
		return cat.category_id
	end
	
	
	
end
