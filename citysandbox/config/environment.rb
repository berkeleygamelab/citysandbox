# Load the rails application
require File.expand_path('../application', __FILE__)

::FT = GData::Client::FusionTables.new
::FT.clientlogin("ian_norris@berkeley.edu", "norrisi154")
ENV['question_table'] = ::FT.show_tables.select{|t| t.name == "Question_Locations"}.first.id
ENV['challenge_table'] = ::FT.show_tables.select{|t| t.name == "Challenge_Locations"}.first.id
ENV['event_table'] = ::FT.show_tables.select{|t| t.name == "Event_Locations"}.first.id



@why_not_global = 2

# Initialize the rails application
Citysandbox::Application.initialize!
