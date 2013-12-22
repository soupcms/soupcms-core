require 'tilt'
require 'sprockets'
require 'soupcms/core'
require 'rack/cache'
require 'faraday'
require 'faraday_middleware'

use Rack::Cache,
    :metastore   => 'heap:/',
    :entitystore => 'heap:/',
    :verbose     => true

SoupCMS::Core::Utils::HttpClient.connection = Faraday.new do |faraday|
  faraday.use FaradayMiddleware::RackCompatible, Rack::Cache::Context,
              :metastore   => 'heap:/',
              :entitystore => 'heap:/',
              :verbose => true,
              :ignore_headers => %w[Set-Cookie X-Content-Digest]

  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

Sprockets::Helpers.configure do |config|
  config.digest = true
end


map '/assets' do
  sprockets_envrionment = SoupCMS::Core::Config.configs.sprockets
  run sprockets_envrionment
end

map '/' do
  run SoupCMSApp
end