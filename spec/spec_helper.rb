require 'rspec'
require 'nokogiri'
require 'rack/test'
require 'soupcms/core'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

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
