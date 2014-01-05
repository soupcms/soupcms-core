require 'spec_helper'

describe 'Redirects' do
  include Rack::Test::Methods

  def app
    app = SoupCMSRackApp.new
    app.set_redirect('http://example.com/','http://www.example.com/home')
    app.set_redirect('http://www.example.com/','http://www.example.com/home',302)
    app
  end

  it 'should should return redirect with default 301 code ' do
    get 'http://example.com/'
    expect(last_response.status).to eq(301)
    expect(last_response.headers['Location']).to eq('http://www.example.com/home')
  end

  it 'should should return redirect with set redirect code ' do
    get 'http://www.example.com/'
    expect(last_response.status).to eq(302)
    expect(last_response.headers['Location']).to eq('http://www.example.com/home')
  end

  it 'should should return redirect with default 301 code ' do
    get 'http://example.com'
    expect(last_response.status).to eq(301)
    expect(last_response.headers['Location']).to eq('http://www.example.com/home')
  end

end