require 'multi_json'
require 'faraday'
require 'elasticsearch'




class Base
  attr_accessor :esc
  
  def initialize
    @esc = Elasticsearch::Client.new
  end

  def health
    @esc.cluster.health
  end

end