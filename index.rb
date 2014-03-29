#!/usr/bin/env ruby

require './models/session'
require './models/event'





# 5000000.times do
#   session = Session.create
#   session.save
# end


1000000.times do
  event = Event.create()
  # puts event.inspect
end







