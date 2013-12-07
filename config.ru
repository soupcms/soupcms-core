require 'tilt'
require 'sprockets'
require 'soupcms/core'

Sprockets::Helpers.configure do |config|
  config.digest = true
end


map '/assets' do
  sprockets_envrionment = SoupCMSApp.config.sprockets
  run sprockets_envrionment
end

map '/' do
  run SoupCMSApp
end