require 'tilt'
require 'sprockets'
require 'soupcms/core'

require 'rack/cache'
require 'faraday'
require 'faraday_middleware'


use Rack::Cache,
    :metastore   => 'heap:/',
    :entitystore => 'heap:/',
    :verbose     => false

# http client with caching based on cache headers
SoupCMS::Core::Utils::HttpClient.connection = Faraday.new do |faraday|
  faraday.use FaradayMiddleware::RackCompatible, Rack::Cache::Context,
              :metastore   => 'heap:/',
              :entitystore => 'heap:/',
              :verbose => false,
              :ignore_headers => %w[Set-Cookie X-Content-Digest]

  faraday.adapter  Faraday.default_adapter
end


map '/assets' do
  Sprockets::Helpers.configure do |config|
    config.digest = true
  end
  run SoupCMS::Core::Config.configs.sprockets
end

map '/' do
  run SoupCMSRackApp.new
end


