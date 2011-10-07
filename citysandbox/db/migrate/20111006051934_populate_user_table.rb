class PopulateUserTable < ActiveRecord::Migration
  def up
    Users.create :login => "Bob", :password => "password", :email => "shirleytemple@cox.net"
    Users.create :login => "Sally", :password => "password", :email => "shirley@cox.net"
    Users.create :login => "Shirley", :password => "derp", :email => "shirleytemple@cox.net"
    Users.create :login => "Curly", :password => "der", :email => "shirley@cox.net"
    Users.create :login => "Mo", :password => "gersa", :email => "shirleytemple@cox.net"
    
    Questions.create :user_id => 2, :title => "Unholiness", :description => "Myagh", :location => 2, :x_coordinate => 4, :y_coordinate => 5
    Questions.create :user_id => 2, :title => "Face challenge!", :description => "Myagh", :location => 2, :x_coordinate => 4, :y_coordinate => 5
    Questions.create :user_id => 1, :title => "Serendipity", :description => "Myagh", :location => 2, :x_coordinate => 4, :y_coordinate => 5
    Questions.create :user_id => 1, :title => "Sadness", :description => "Myagh", :location => 2,:x_coordinate => 4, :y_coordinate => 5
    Questions.create :user_id => 3, :title => "Misery", :description => "Myagh", :location => 2, :x_coordinate => 4, :y_coordinate => 5
  end

  def down
  end
end
