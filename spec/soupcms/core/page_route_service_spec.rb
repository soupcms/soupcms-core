require 'spec_helper'

include SoupCMS::Core::Model

describe SoupCMS::Core::PageRouteService do

  let (:app_info) { AppInfo.new('soupcms-test') }
  let (:context) { RequestContext.new(app_info) }
  let (:page_route_service) { SoupCMS::Core::PageRouteService.new(context) }

  context 'page slugs' do
    it 'should load page for valid page url' do
      stub_request(:get, /latest-posts$/).to_return({body: read_file('pages/home')})
      page = page_route_service.find('/latest-posts')
      expect(page).to be_kind_of(Page)
      expect(page.model).to be_kind_of(Document)
      expect(page.model['title']).to eq('Page title')
    end

    it 'should not find a page for invalid url' do
      stub_request(:get, /invalid$/).to_return({status: 404})
      page = page_route_service.find('/invalid')
      expect(page).to be_nil
    end

  end

  context 'model slugs' do
    it 'should find a page with model' do
      stub_request(:get, /posts\/slug\/my-first-blog-post$/).to_return({body: {document: 'document'}.to_json})
      stub_request(:get, /pages\/model\/posts$/).to_return({body: read_file('pages/home')})
      page = page_route_service.find('/posts/my-first-blog-post')
      expect(page).to be_kind_of(Page)
      expect(page.model).to be_kind_of(Document)
    end

    it 'should not find a page for invalid slug' do
      stub_request(:get, /posts\/slug\/invalid-blog-post$/).to_return({status: 404})
      page = page_route_service.find('/posts/invalid-blog-post')
      expect(page).to be_nil
    end
  end
end