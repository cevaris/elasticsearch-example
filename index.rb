#!/usr/bin/env ruby

require './models/event'
require 'tweetstream'
require 'elasticsearch'


creds = JSON.parse(File.read(".credentials.json"))

TweetStream.configure do |config|
  config.consumer_key       = creds['consumer_key']
  config.consumer_secret    = creds['consumer_secret']
  config.oauth_token        = creds['oauth_token']
  config.oauth_token_secret = creds['oauth_token_secret']
  config.auth_method        = :oauth
end

$esc = Elasticsearch::Client.new

# event = {:created_at=>"Sat Mar 29 03:56:49 +0000 2014", :id=>449757042459152384, :id_str=>"449757042459152384", :text=>"椿ちゃん、どこにいるの〜〜", :source=>"<a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>", :truncated=>false, :in_reply_to_status_id=>nil, :in_reply_to_status_id_str=>nil, :in_reply_to_user_id=>nil, :in_reply_to_user_id_str=>nil, :in_reply_to_screen_name=>nil, :user=>{:id=>1097723274, :id_str=>"1097723274", :name=>"kaanaa", :screen_name=>"k7flux", :location=>"", :url=>nil, :description=>"愛犬と過ごすお休みが大好き。クラフトビア、美味しいもの、大好きです。", :protected=>false, :followers_count=>28, :friends_count=>33, :listed_count=>0, :created_at=>"Thu Jan 17 10:01:01 +0000 2013", :favourites_count=>9, :utc_offset=>nil, :time_zone=>nil, :geo_enabled=>true, :verified=>false, :statuses_count=>319, :lang=>"ja", :contributors_enabled=>false, :is_translator=>false, :is_translation_enabled=>false, :profile_background_color=>"C0DEED", :profile_background_image_url=>"http://abs.twimg.com/images/themes/theme1/bg.png", :profile_background_image_url_https=>"https://abs.twimg.com/images/themes/theme1/bg.png", :profile_background_tile=>false, :profile_image_url=>"http://pbs.twimg.com/profile_images/420536309640216579/rQOfIuDE_normal.jpeg", :profile_image_url_https=>"https://pbs.twimg.com/profile_images/420536309640216579/rQOfIuDE_normal.jpeg", :profile_banner_url=>"https://pbs.twimg.com/profile_banners/1097723274/1389098596", :profile_link_color=>"0084B4", :profile_sidebar_border_color=>"C0DEED", :profile_sidebar_fill_color=>"DDEEF6", :profile_text_color=>"333333", :profile_use_background_image=>true, :default_profile=>true, :default_profile_image=>false, :following=>nil, :follow_request_sent=>nil, :notifications=>nil}, :geo=>nil, :coordinates=>nil, :place=>nil, :contributors=>nil, :retweet_count=>0, :favorite_count=>0, :entities=>{:hashtags=>[], :symbols=>[], :urls=>[], :user_mentions=>[]}, :favorited=>false, :retweeted=>false, :filter_level=>"medium", :lang=>"ja"}
# puts event[:created_at]

# puts Event.save(event)

TweetStream::Client.new.sample do |status|
  event = status.attrs
  # puts Event.save(event)
  puts event
  # puts event
end