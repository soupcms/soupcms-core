source 'https://rubygems.org'

gemspec

gem 'sprockets', github: 'sstephenson/sprockets'

gem 'soupcms-common', github: 'soupcms/soupcms-common'
#gem 'soupcms-common', path: '../soupcms-common'

group :development do
  gem 'puma'
  gem 'rack-cache'
  gem 'mongo'
  gem 'bson_ext'
  gem 'faraday'
  gem 'faraday_middleware'
  gem 'nokogiri'
end

group :test do
  gem 'rspec', '~> 3.0.0.beta1'
  gem 'rake'
  gem 'rack-test'
  gem 'webmock'
end