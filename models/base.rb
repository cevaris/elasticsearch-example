require 'multi_json'
require 'faraday'
require 'elasticsearch/api'


class Base
  include Elasticsearch::API

  ES_CONN = ::Faraday::Connection.new url: 'http://localhost:9200'

  def initialize
    @method = nil
    @path = nil
  end

  def health
    self.cluster.health
  end

  def perform_request(method, path, params, body)
    puts "--> #{method.upcase} #{path} #{params} #{body}"
    
    ES_CONN.run_request method.downcase.to_sym, path,
      ( body ? MultiJson.dump(body): nil ),
      {'Content-Type' => 'application/json'}
  end


end