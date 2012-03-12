class Category < ActiveRecord::Base
	has_many :item_templates
	attr_accessor :name
	attr_accessor :cat_id
	validates_uniqueness_of :name
	has_many :users, :through => :user_categories
	
	def get_n_popular_cats(n)
		return Category.find(:order => 'popularity', :limit => n)
	end
	

	def auto_fill(text)
		cats = Category.find(:all, :conditions => ['name LIKE ?', text + '%'])
		results = []
		cats.each |cat| do:
			results += [cat.name]
		return results
	end	
	
	def return_cat_id(text)
		cat = Category.where(:name => text)
		if cat is nil
			return nil
		return cat.category_id
	end
	
	
	
end
