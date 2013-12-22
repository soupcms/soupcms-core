require 'tilt'
require 'sprockets'
require 'soupcms/core'
require 'rack/cache'

use Rack::Cache,
    :metastore   => 'heap:/',
    :entitystore => 'heap:/',
    :verbose     => true

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