require 'weighted_randomizer'
require 'elasticsearch'
require 'multi_json'

class Session

  attr_accessor :path

  def attrs
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

  def initialize(path)
    @path = path
  end

  def self.agg(feild)
    query = {}
    query[:aggs] = {}
    query[:aggs][:path] = {}
    query[:aggs][:path] = {}
    query[:aggs][:path][:terms] = {}
    query[:aggs][:path][:terms][:field] = feild
    # query[:aggs][:path][:histogram] = {}
    # query[:aggs][:path][:histogram][:field] = keyword

    puts query
    $esc ||= Elasticsearch::Client.new
    $esc.search(index: 'es', type: 'events', body: query)
  end

  def save()
    $esc ||= Elasticsearch::Client.new
    $esc.index(index: 'es', type: 'events', body: self.attrs)
  end
  
  def self.create()
    weights = {
      a:5, b:5, c:25, d:15, e:10, f: 4, g: 20, h: 5, i: 4, j: 7
    }

    session = []

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
      event[:message] = item[0]
      event[:status] = item[1]
      event[:client_timestamp] = Time.now.to_i - rand(1..100)
      event[:second] = Time.now.getutc.sec
      event[:minute_bucket] = Time.now.getutc.min
      event[:hour_bucket] = Time.now.getutc.hour
      event[:week_bucket] = Time.now.getutc.yday/7
      event[:day_bucket] = Time.now.getutc.day
      event[:month_bucket] = Time.now.getutc.month
      event[:year_bucket] = Time.now.getutc.year
      session << event
    end

    session = session.sort_by { |k| k[:client_timestamp] }
    Session.new(session)
  end

end