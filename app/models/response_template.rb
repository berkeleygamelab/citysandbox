class ResponseTemplate < ActiveRecord::Base
  acts_as_nested_set
  
  belongs_to :item_template, :foreign_key => :item_id
  attr_accessible :response, :parent_id

  def upvote
    self.score = self.score + 1
  end

  def downvote
    self.score = self.score - 1
  end

  def get_replies
    @replies = ResponseTemplate.where("item_id = ? AND type = ? AND lft > ? AND rgt < ?", :item_id, :type, :lft, :rgt)
  end

end
