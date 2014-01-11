require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  def app
    app = SoupCMSRackApp.new
    app.router.add 'chapters/:release_version/:slug', SoupCMS::Core::Controller::ModelController, 'chapters'
    app
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

  context 'get chapter with multiple keys' do
    before do
      stub_request(:get,/chapters\/release_version\/v0\.5\.x\/slug\/first-chapter$/).to_return( { body: {document: 'document'}.to_json } )
      stub_request(:get,/pages\/meta\.model\/chapters/).to_return( { body: read_file('pages/home') } )
      get '/soupcms-test/chapters/v0.5.x/first-chapter'
    end

    it { expect(last_response.status).to eq(200) }
    it { expect(html_response).to have_title('Page title - soupcms-test') }
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