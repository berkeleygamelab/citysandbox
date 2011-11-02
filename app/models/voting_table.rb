class VotingTable < ActiveRecord::Base
  
  has_many :voting_records
  
  def total
    return voting_records.sum(:vote)
  end
    
  def average_total(weight)
    return voting_records.sum(:vote)/weight
  end
  def confirm_unique_user(user)
     records = voting_records
     rec = records.where(:user => user)
     return rec.size == 0
   end

   def confirm_unique
     return confirm_unique_user(current_user)
   end
end
