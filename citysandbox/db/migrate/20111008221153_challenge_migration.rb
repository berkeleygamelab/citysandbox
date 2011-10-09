class ChallengeMigration < ActiveRecord::Migration
  def up
    add_column :challenges, :title, :string
    add_column :challenges, :proposal_deadline, :datetime
    add_column :challenges, :review_deadline, :datetime
    add_column :challenges, :vote_deadline, :datetime
  end

  def down
  end
end
