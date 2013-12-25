require 'rspec'
require 'nokogiri'
require 'rack/test'
require 'webmock/rspec'
require 'sprockets'
require 'sprockets-helpers'
require 'soupcms/core'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

SoupCMSCore.configure do |config|
  config.soupcms_api_host_url = 'http://localhost:9292'
  sprockets = config.sprockets
  sprockets.append_path SoupCMS::Core::Template::Manager::DEFAULT_TEMPLATE_DIR
  Sprockets::Helpers.configure do |c|
    c.environment = sprockets
    c.prefix = '/assets'
    c.public_path = nil
  end
end

RSpec.configure do |config|
  config.order = 'random'
  config.expect_with :rspec
  config.mock_with 'rspec-mocks'

  config.include Helpers

  config.before(:suite) do
  end

  config.before(:each) do
  end

  config.after(:suite) do
  end

end
