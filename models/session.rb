require 'weighted_randomizer'
require 'elasticsearch'

class Session

  attr_accessor :path

  def attrs
    # puts instance_variables.inspect
    instance_variables.collect{|ivar| {"#{ivar[1..-1]}" => instance_variable_get(ivar)} }
  end

  def initialize(path)
    @path = path
  end

  def save()
    $esc ||= Elasticsearch::Client.new
    $esc.index(index: 'es', type: 'events', body: self)
  end
  
  def self.create()
    weights = {
      a:5, b:5, c:25, d:15, e:10, f: 4, g: 20, h: 5, i: 4, j: 7
    }

    session = [['open',:info]]

    samples = {
      a: ['login',:info],
      b: ['settings',:info],
      c: ['browse',:info],
      d: ['like',:info],
      e: ['add_to_cart',:info],
      f: ['purchase',:info],
      g: ['search',:info],
      h: ['logout',:error],
      i: ['app_crash',:error],
      j: ['network_timeout',:error],
    }

    sampler = WeightedRandomizer.new(weights)

 
    rand(1..10).times do 
      item = samples[sampler.sample]

      event = {}
      event[:body] = item[0]
      event[:status] = item[1]
      event[:client_timestamp] = Time.now.to_i
      event[:second] = Time.now.getutc.sec
      event[:minute_bucket] = Time.now.getutc.min
      event[:hour_bucket] = Time.now.getutc.hour
      event[:week_bucket] = Time.now.getutc.yday/7
      event[:day_bucket] = Time.now.getutc.day
      event[:month_bucket] = Time.now.getutc.month
      event[:year_bucket] = Time.now.getutc.year
      session << event
    end

    Session.new(session)
  end

end