require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  def app
    SoupCMSRackApp.new
  end

  context 'get blog post' do
    let(:env) { ENV['RACK_ENV'] }

    before do
      env
      ENV['RACK_ENV'] = 'production'
      stub_request(:get,/posts\/slug\/my-first-blog-post$/).to_return( { body: {document: 'document'}.to_json } )
      stub_request(:get,/pages\/meta\.model\/posts$/).to_return( { body: read_file('pages/home') } )
      get '/soupcms-test/posts/my-first-blog-post'
    end

    after do
      ENV['RACK_ENV'] = env
    end

    it { expect(last_response.status).to eq(200) }
    it { expect(last_response.headers['Cache-Control']).to eq('public, max-age=300') }
    it { expect(last_response.headers['Expires']).not_to be_nil }
    it { expect(html_response).to have_title('Page title - soupcms-test') }
    it { expect(html_response).to have_attribute("link[href='/assets/module/bootstrap/page-header/page-header.css']",'href','/assets/module/bootstrap/page-header/page-header.css')}
    it { expect(html_response).to have_attribute("script[src='/assets/module/bootstrap/page-header/page-header.js']",'src','/assets/module/bootstrap/page-header/page-header.js')}
  end

  context 'draft page' do

    it 'should pass draft parameter when requested' do
      stub_request(:get,/pages\/slug\/home\?include=drafts$/).to_return( { body: read_file('pages/home') } )
      get '/soupcms-test/home?include=drafts'
      expect(last_response.status).to eq(200)
    end

  end

end