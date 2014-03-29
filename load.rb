#!/usr/bin/env ruby

require './models/event'
require 'tweetstream'
require 'json'

e = Event.new
puts e.health

creds = JSON.parse(File.read(".credentials.json"))

TweetStream.configure do |config|
  config.consumer_key       = creds['consumer_key']
  config.consumer_secret    = creds['consumer_secret']
  config.oauth_token        = creds['oauth_token']
  config.oauth_token_secret = creds['oauth_token_secret']
  config.auth_method        = :oauth
end

TweetStream::Client.new.sample do |status|
 puts status.text
end