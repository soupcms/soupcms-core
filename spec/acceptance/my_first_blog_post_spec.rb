require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  def app
    SoupCMSRackApp.new
  end


  context 'get blog post' do
    before do
      stub_request(:get,/posts\/slug\/my-first-blog-post$/).to_return( { body: {document: 'document'}.to_json } )
      stub_request(:get,/pages\/meta\.model\/posts$/).to_return( { body: read_file('pages/home') } )
      get '/soupcms-test/posts/my-first-blog-post'
    end

    it { expect(last_response.status).to eq(200) }
    #it { expect(last_response.headers['Cache-Control']).to eq('public, max-age=300') }
    #it { expect(last_response.headers['Expires']).not_to be_nil }
    it { expect(html_response).to have_title('Page title - soupcms-test') }
    it { expect(html_response).to have_attribute("link[href='/assets/module/bootstrap/page-header/page-header.css']",'href','/assets/module/bootstrap/page-header/page-header.css')}
    it { expect(html_response).to have_attribute("script[src='/assets/module/bootstrap/page-header/page-header.js']",'src','/assets/module/bootstrap/page-header/page-header.js')}
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
      expect(last_response.headers['Cache-Control']).to be_nil
      expect(last_response.headers['Expires']).to be_nil
    end

    it 'invalid posts slug' do
      stub_request(:get,/posts\/slug\/invalid-post$/).to_return( { status: 404 } )
      get '/soupcms-api-test/posts/invalid-post'
      expect(last_response.status).to eq(404)
    end

  end

  context 'draft page' do

    it 'should pass draft parameter when requested' do
      stub_request(:get,/pages\/slug\/home\?include=drafts$/).to_return( { body: read_file('pages/home') } )
      get '/soupcms-test/home?include=drafts'
      expect(last_response.status).to eq(200)
    end

  end

end