require 'rspec'
require 'nokogiri'
require 'rack/test'
require 'webmock/rspec'
require 'soupcms/core'
require 'sprockets'
require 'sprockets-helpers'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.order = 'random'
  config.expect_with :rspec
  config.mock_with 'rspec-mocks'

  config.include Helpers


  config.before(:suite) do

    SoupCMSCore.configure do |config|
      config.soupcms_api_host_url = 'http://localhost:9292'
      sprockets = config.sprockets
      Sprockets::Helpers.configure do |c|
        c.environment = sprockets
        c.prefix = '/assets'
        c.public_path = nil
      end
    end

  end

  config.before(:each) do
  end

  config.after(:suite) do
  end

end
