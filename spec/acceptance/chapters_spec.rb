require 'spec_helper'

describe 'Blog Post' do
  include Rack::Test::Methods

  def app
    app = SoupCMSRackApp.new
    app.router.add 'chapters/:release_version/:slug', SoupCMS::Core::Controller::ModelController, 'chapters'
    app
  end

  context 'get chapter with multiple keys' do
    before do
      stub_request(:get,/chapters\/release_version\/v0\.5\.x\/slug\/first-chapter$/).to_return( { body: {document: 'document'}.to_json } )
      stub_request(:get,/pages\/meta\.model\/chapters\/meta\.slug\/first-chapter$/).to_return( { status: 404, body: "{ \"error\": \"page not found.\" }" } )
      stub_request(:get,/pages\/meta\.model\/chapters/).to_return( { body: read_file('pages/home') } )
      get '/soupcms-test/chapters/v0.5.x/first-chapter'
    end

    it { expect(last_response.status).to eq(200) }
    it { expect(html_response).to have_title('Page title - soupcms-test') }
  end

end