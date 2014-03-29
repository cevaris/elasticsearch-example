#!/usr/bin/env ruby

require './models/session'


sessions =  Session.agg('message')
aggs = sessions['aggregations']
puts aggs


# sessions.each |session|

# end