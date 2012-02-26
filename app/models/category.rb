class Category < ActiveRecord::Base
	has_many :tags
	attr_accessor :cat_name
	attr_accessor :cat_id
	validates_uniqueness_of :cat_name
	has_and_belongs_to_many :users
	
	def get_n_popular_cats(n)
		return Category.find(:order => 'popularity', :limit => n)
	end
	

	def auto_fill(text)
		cats = Category.find(:all, :conditions => ['cat_name LIKE ?', text + '%'])
		results = []
		cats.each |cat| do:
			results += [cat.cat_name]
		return results
	end	
	
	def return_cat_id(text)
		cat = Category.where(:cat_name => text)
		if cat is nil:
			return nil
		return cat.category_id
	end
	
	
	
end
