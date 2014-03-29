#!/usr/bin/env ruby

require './models/session'





5000000.times do
  session = Session.create
  session.save
end






