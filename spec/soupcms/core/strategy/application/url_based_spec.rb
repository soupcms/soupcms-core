require 'spec_helper'
require 'rack/request'
require 'rack/mock'

describe SoupCMS::Core::Strategy::Application::UrlBased do

  context 'url based strategy' do
    let(:app_strategy) { SoupCMS::Core::Strategy::Application::UrlBased.new(Rack::Request.new(Rack::MockRequest.env_for('http://example.com:8080/soupcms-test/posts/slug/my-first-blog-post?include=drafts'))) }

    it { expect(app_strategy.app_name).to eq('soupcms-test') }
    it { expect(app_strategy.display_name).to eq('soupcms-test') }
    it { expect(app_strategy.path).to eq('posts/slug/my-first-blog-post') }
    it { expect(app_strategy.soupcms_api_url).to eq('http://example.com:8080/api/soupcms-test') }
    it { expect(app_strategy.not_found_message).to eq("Page 'posts/slug/my-first-blog-post' not found in application 'soupcms-test'") }
  end

  context 'application defined for the given application name' do

    before(:each) do
      SoupCMS::Core::Strategy::Application::UrlBased.apps = { 'test-app' => application}
    end

    after(:each) do
      SoupCMS::Core::Strategy::Application::UrlBased.apps = {}
    end

    let(:application) { SoupCMS::Core::Model::Application.new('test-app', 'Testing Application', 'http://localhost:9291/api')}
    let(:app_strategy) { SoupCMS::Core::Strategy::Application::UrlBased.new(Rack::Request.new(Rack::MockRequest.env_for('http://example.com:8080/test-app/posts/slug/my-first-blog-post?include=drafts')))  }

    it { expect(app_strategy.application).to eq(application) }
    it { expect(app_strategy.application.display_name).to eq('Testing Application') }
    it { expect(app_strategy.application.soupcms_api_url).to eq('http://localhost:9291/api') }
  end



end