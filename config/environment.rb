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
ENV['csb_locations'] = 2036527.to_s

#initialize constants for popularity sort
ENV['response_value'] = 1.to_s
ENV['followed_value'] = 2.to_s

ENV['flickr_key'] = '1228cbd1e0d67c0e3bf5715d576c0e12'
ENV['flickr_secret'] = '2b99455c7381e96e'
ENV['token_cache'] = "token_cache.yml"
ENV['auth_token'] = '72157628078360977-05a6db370fe2959b'

@why_not_global = 2

Fleakr.api_key = ENV['flickr_key']
Fleakr.shared_secret = ENV['flickr_secret']
Fleakr.auth_token = ENV['auth_token']



# Initialize the rails application
Citysandbox::Application.initialize!
