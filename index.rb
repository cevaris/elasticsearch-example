#!/usr/bin/env ruby

require './models/session'
require 'multi_json'






session = Session.create
# session.attrs
puts session.attrs
# puts MultiJson.dump(session)






