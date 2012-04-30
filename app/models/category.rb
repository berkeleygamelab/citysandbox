class Category < ActiveRecord::Base
  has_many :item_templates, :through =>:categoryholders
  validates :name, :presence => true
  attr_accessor :cat_id
  validates_uniqueness_of :name
  has_many :users, :through => :user_categories

  def get_n_popular_cats(n)
    return Category.where(:order => 'popularity').limit(n)
  end


  def auto_fill(text)
    cats = Category.where("name LIKE ?", text + '%')
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

  def get_default_cats
    return Category.where(:default_cat => true)
  end

  def get_my_categories
    User_Categories = UserCategory.where(:user_id => self.current_user_id)
    result = []
    for User_Categories.each do |cat|
      result += Category.find_by_id(cat.cat_id)
      end
    return result
  end

end
