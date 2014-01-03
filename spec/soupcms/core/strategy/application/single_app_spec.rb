require 'spec_helper'
require 'rack/request'
require 'rack/mock'

describe SoupCMS::Core::Strategy::Application::SingleApp do

  before(:each) do
    SoupCMS::Core::Strategy::Application::SingleApp.app_name = 'soupcms-test'
    SoupCMS::Core::Strategy::Application::SingleApp.display_name = 'soupCMS Test'
    SoupCMS::Core::Strategy::Application::SingleApp.soupcms_api_url = 'http://example.com:8081/api/soupcms-test'
  end

  let(:app_strategy) { SoupCMS::Core::Strategy::Application::SingleApp.new(Rack::Request.new(Rack::MockRequest.env_for('http://example.com:8080/posts/slug/my-first-blog-post?include=drafts'))) }

  it { expect(app_strategy.app_name).to eq('soupcms-test') }
  it { expect(app_strategy.display_name).to eq('soupCMS Test') }
  it { expect(app_strategy.path).to eq('posts/slug/my-first-blog-post') }
  it { expect(app_strategy.soupcms_api_url).to eq('http://example.com:8081/api/soupcms-test') }
  it { expect(app_strategy.not_found_message).to eq("Page 'posts/slug/my-first-blog-post' not found in application 'soupcms-test'") }

end