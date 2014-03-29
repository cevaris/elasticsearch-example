#!/usr/bin/env ruby

require './models/session'


sessions =  Session.agg('message')
# aggs = sessions['aggregations']
sessions['hits']['hits'].each do |event|
  puts event['_source']['path']
end


# sessions.each |session|

# end