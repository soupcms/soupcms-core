require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  def app
    SoupCMSApp
  end


  context 'get blog post' do
    before do
      stub_request(:get,/posts\/slug\/my-first-blog-post$/).to_return( { body: {document: 'document'}.to_json } )
      stub_request(:get,/pages\/model\/posts$/).to_return( { body: read_file('pages/home') } )
      get '/soupcms-test/posts/my-first-blog-post'
    end

    it { expect(last_response.status).to eq(200) }
    it { expect(html_response).to have_title('Page title') }
    it { expect(html_response).to have_attribute('link','href','/assets/module/bootstrap/jumbotron/jumbotron.css')}
    it { expect(html_response).to have_attribute('script','src','/assets/module/bootstrap/jumbotron/jumbotron.js')}
  end

  context 'bad request urls' do
    it 'url without slug' do
      get '/soupcms-test'
      expect(last_response.status).to eq(404)
    end

    it 'invalid page slug' do
      stub_request(:get,/pages\/slug\/invalid-url/).to_return( { status: 404 } )
      get '/soupcms-api-test/invalid-url'
      expect(last_response.status).to eq(404)
    end

    it 'invalid posts slug' do
      stub_request(:get,/posts\/slug\/invalid-post$/).to_return( { status: 404 } )
      get '/soupcms-api-test/posts/invalid-post'
      expect(last_response.status).to eq(404)
    end

  end

end