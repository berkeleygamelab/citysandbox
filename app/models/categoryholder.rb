class Categoryholder < ActiveRecord::Base
  belongs_to :category
  belongs_to :item_template
end
