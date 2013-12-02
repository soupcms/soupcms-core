require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  def app
    SoupCMSApp
  end


  context 'get blog post' do
    before do
      get '/soupcms-api-test/posts/my-first-blog'
    end

    it { expect(last_response.status).to eq(200) }
    it { expect(html_response).to have_title('My first blog post') }
  end

end