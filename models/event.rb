require 'weighted_randomizer'
require 'elasticsearch'
require 'multi_json'
require 'base64'
require 'securerandom'

class Event

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
    $esc.index(index: 'es', type: 'events', body: self.attrs)
  end



  def self.get_event(event, app=1)

    if app == 1
      
      case event
      when :scroll_up, :scroll_up, :swipe_left
        {name: event, status: :info}
      when :open, :close, :login, :logout
        {name: event, status: :info}
      when :create_task, :comment_task, :delete_task
        {name: event, value: random(1..1000), status: :info}
      when :network_timeout, :app_crash
        {name: event, status: :error}
      else
        raise "Unknown event type: #{event}}"
      end

    elsif app == 2

      case event
      when :scroll_up, :scroll_up, :swipe_left
        {name: event, status: :info}
      when :start, :end, :login, :logout
        {name: event, status: :info}
      when :click_page, :click_photo, :like_page, :like_photo, :commented_page, :commented_photo
        {name: event, value: random(1..1000), status: :info}
      when :network_timeout, :app_crash
        {name: event, status: :error}
      else
        raise "Unknown event type: #{event}}"
      end

    elsif app == 3

      case event
      when :scroll_up, :scroll_up, :swipe_left
        {name: event, status: :info}
      when :start, :end, :login, :logout
        {name: event, status: :info}
      when :search
        {name: event, value: LoremIpsum.random[1..15], status: :info}
      when :click_page, :like_page
        {name: event, value: random(1..1000), status: :info}
      when :network_timeout, :app_crash
        {name: event, status: :error}
      else
        raise "Unknown event type: #{event}}"
      end

    end
    
  end
  
  def self.create()
    weights = {
      a:5, b:5, c:25, d:15, e:10, f: 4, g: 20, h: 5, i: 4, j: 7
    }

    session = []

    samples = {
      a: :login,
      b: :settings,
      c: :click_page,
      d: :like_photo,
      d: :like_photo,
      e: :add_to_cart,
      f: :purchase,
      g: :search,
      h: :logout,
      i: :app_crash,
      j: :network_timeout,
    }

    sampler = WeightedRandomizer.new(weights)
    item = samples[sampler.sample]     
    event = Event.new
    event.message = item[0]
    event[:status] = item[1]
    event[:client_timestamp] = Time.now.to_i - rand(1..100)
    event[:second] = Time.now.getutc.sec
    event[:minute_bucket] = Time.now.getutc.min
    event[:hour_bucket] = Time.now.getutc.hour
    event[:week_bucket] = Time.now.getutc.yday/7
    event[:day_bucket] = Time.now.getutc.day
    event[:month_bucket] = Time.now.getutc.month
    event[:year_bucket] = Time.now.getutc.year

    event
    Session.new(session)
  end

end