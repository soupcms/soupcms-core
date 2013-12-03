require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  def app
    SoupCMSApp
  end


  context 'get blog post' do
    before do
      stub_request(:get,/posts\/slug\/my-first-blog-post$/).to_return( { body: {page: 'page'}.to_json } )
      get '/soupcms-test/posts/my-first-blog-post'
    end

    it { expect(last_response.status).to eq(200) }
    it { expect(html_response).to have_title('My first blog post') }
  end

  context 'bad request urls' do
    it 'url without slug' do
      get '/invalid-request'
      expect(last_response.status).to eq(404)
    end

    #it 'invalid slug' do
    #  get '/soupcms-api-test/invalid-url'
    #  expect(last_response.status).to eq(404)
    #end

  end

end