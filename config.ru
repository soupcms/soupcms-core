require 'tilt'
require 'sprockets'
require 'soupcms/core'

require 'rack/cache'
require 'faraday'
require 'faraday_middleware'


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
    SoupCMS::Common::Strategy::Application::SingleApp.configure do |app|
      app.app_name = 'soupcms-test'
      app.display_name = 'soupCMS Test'
      app.soupcms_api_url = 'http://localhost:9292/api'
      app.app_base_url = 'http://localhost:9291/'
    end
    config.application_strategy = SoupCMS::Common::Strategy::Application::SingleApp
  end
  app = SoupCMSRackApp.new
  app.set_redirect('http://soupcms.dev:9291/','http://www.soupcms.dev:9291/home')
  app.set_redirect('http://www.soupcms.dev:9291/','http://www.soupcms.dev:9291/home')
  run app
end


