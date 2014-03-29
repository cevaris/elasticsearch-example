require './models/base'

class Event < Base

  def gen_events(app, client)

    exp = app.experiments.sample
    var = exp.variations.sample

    weights = {a:15, b:40, c:25, d:5, e:10, f: 5}
    samples = {
      a: [['open',:info], ['login',:info], ['settings',:info], ['close',:info]],
      b: [['open',:info], ['login',:info], ['browse',:info], ['browse',:info], ['browse',:info], ['close',:info]],
      c: [['open',:info], ['login',:info], ['browse',:info], ['close',:info]],
      d: [['open',:info], ['login',:info], ['app_crash',:error]],
      e: [['open',:info], ['login',:info], ['add_to_cart',:info], ['close',:info]],
      f: [['open',:info], ['app_crash',:error]]
    }
    sampler = WeightedRandomizer.new(weights)
    event_path = samples[sampler.sample]

    events = []
    event_path.each do |item|
      event = {}
      event[:body] = item[0]
      event[:status] = item[1]
      event[:client_timestamp] = Time.now.to_i
      event[:second] = Time.now.to_i
      event[:minute_bucket] = Time.now.getutc.min
      event[:hour_bucket] = Time.now.getutc.hour
      event[:week_bucket] = Time.now.getutc.yday/7
      event[:day_bucket] = Time.now.getutc.day
      event[:month_bucket] = Time.now.getutc.month
      event[:year_bucket] = Time.now.getutc.year

      event[:app_id] = app.id
      event[:app_name] = app.name
      event[:app_access_token] = app.access_token
      event[:app_created_at] = app.created_at

      event[:client_id] = client.id
      event[:client_library] = client.library
      event[:client_version] = client.version
      event[:client_manufacturer] = client.manufacturer
      event[:client_os] = client.os
      event[:client_os_version] = client.os_version
      event[:client_model] = client.model
      event[:client_carrier] = client.carrier
      event[:client_token] = client.token
      event[:client_created_at] = client.created_at
      events << event
    end

    return events
    
  end


  
end