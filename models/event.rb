require 'weighted_randomizer'
require 'elasticsearch'
require 'multi_json'
require 'base64'
require 'securerandom'
require 'lorem_ipsum_amet'

class Event

  attr_accessor :id, :body, :metadata, :client_timestamp, :server_timestamp
  attr_accessor :second, :minute, :hour, :week, :day, :month, :year

  def attrs
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

  def self.agg(field, sort="desc")
    query = {
      filter: { 
        and: [
          { term: { "message" => "login" } }
        ] 
      }
    }

    puts query
    $esc ||= Elasticsearch::Client.new
    $esc.search(index: 'es', type: 'events', body: query)
  end

  def save()
    $esc ||= Elasticsearch::Client.new
    puts self.attrs
    # $esc.index(index: 'es', type: 'events', body: )
  end



  def self.get_event(event)
    case event
    when :scroll_up, :scroll_down, :swipe_left, :swipe_right
      return {name: event, status: :info}, {app_id: rand(1..3), client_id: rand(1..50)}
    when :open, :close, :login, :logout, :settings
      return {name: event, status: :info}, {app_id: rand(1..3), client_id: rand(1..50)}
    when :network_timeout, :app_crash
      return {name: event, status: :error}, {app_id: rand(1..3), client_id: rand(1..50)}
    
    when :create_task, :comment_task, :delete_task
      return {name: event, value: rand(1..1000), status: :info}, {app_id: 1, client_id: rand(1..50)}
    when :click_page, :click_photo, :like_page, :like_photo, :commented_page, :commented_photo
      return {name: event, value: rand(1..1000), status: :info}, {app_id: 2, client_id: rand(1..50)}
    when :search
      return {name: event, value: LoremIpsum.random[1..15], status: :info}, {app_id: 3, client_id: rand(1..50)}
    when :add_to_cart, :purchase
      return {name: event, value: rand(1..1000), status: :info}, {app_id: 4, client_id: rand(1..50)}
    
    else
      raise "Unknown event type: #{event}}"
    end

  end
  
  def self.create()
    weights = {
      open: 20, close: 20,
      login:5, logout:5, settings:5, 
      scroll_up:10, scroll_up:10, swipe_left:10, 
      app_crash: 4, network_timeout: 7,
      click_page:25, like_photo:15, 
      add_to_cart:10, purchase: 4,
      create_task: 10, comment_task: 20, delete_task:5,
      click_page:20, click_photo:14, like_page:10, like_photo:12, commented_page:7, commented_photo:8,
      search: 10
    }

    sampler = WeightedRandomizer.new(weights)
    item = Event.get_event(sampler.sample)

    event = Event.new
    event.server_timestamp = Time.now.getutc.to_i
    event.client_timestamp = Time.now.getutc.to_i - rand(10..1000)
    event.id = "#{event.client_timestamp}-#{item[1][:app_id]}-#{item[1][:client_id]}"
    event.body = item[0]
    event.metadata = item[1]
    event.second = Time.now.getutc.sec
    event.minute = Time.now.getutc.min
    event.hour = Time.now.getutc.hour
    event.week = Time.now.getutc.yday/7
    event.day = Time.now.getutc.day
    event.month = Time.now.getutc.month
    event.year = Time.now.getutc.year
    event.save
  end

end