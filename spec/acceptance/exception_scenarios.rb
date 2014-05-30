require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  context 'bad request urls' do
    it 'url without slug' do
      get '/soupcms-test'
      expect(last_response.status).to eq(404)
    end

    it 'invalid page slug' do
      stub_request(:get,/pages\/slug\/invalid-url/).to_return( { status: 404 } )
      get '/soupcms-api-test/invalid-url'
      expect(last_response.status).to eq(404)
      expect(last_response.headers['Cache-Control']).to eq('public, max-age=300')
      expect(last_response.headers['Expires']).not_to be_nil
    end

    it 'invalid posts slug' do
      stub_request(:get,/posts\/slug\/invalid-post$/).to_return( { status: 404 } )
      get '/soupcms-api-test/posts/invalid-post'
      expect(last_response.status).to eq(404)
    end

  end


end