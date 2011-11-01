# Load the rails application
require File.expand_path('../application', __FILE__)

::FT = GData::Client::FusionTables.new

file = File.new("options.txt", "r")
username = file.gets
password = file.gets

::FT.clientlogin(username, password)
ENV['question_table'] = ::FT.show_tables.select{|t| t.name == "Question_Locations"}.first.id
ENV['challenge_table'] = ::FT.show_tables.select{|t| t.name == "Challenge_Locations"}.first.id
ENV['event_table'] = ::FT.show_tables.select{|t| t.name == "Event_Locations"}.first.id


#initialize constants for popularity sort
ENV['response_value'] = 1.to_s
ENV['followed_value'] = 2.to_s



@why_not_global = 2



# Initialize the rails application
Citysandbox::Application.initialize!
