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
  sprockets = SoupCMSCore.config.sprockets
  sprockets.append_path SoupCMS::Core::Template::Manager::DEFAULT_TEMPLATE_DIR
  Sprockets::Helpers.configure do |config|
    config.environment = sprockets
    config.prefix = '/assets'
    config.public_path = nil
    config.digest = true
  end
  run sprockets
end

map '/' do
  SoupCMSCore.configure do |config|
    config.soupcms_api_host_url = 'http://localhost:9292/'
  end
  run SoupCMSRackApp.new
end


