require 'spec_helper'

include SoupCMS::Core::Model

describe SoupCMS::Core::Application do

  let (:app_info) { AppInfo.new('soupcms-test') }
  let (:application) { SoupCMS::Core::Application.new(app_info) }
  let (:context) { PageContext.new(app_info) }

  context 'page slugs' do
    it 'should load page for valid page url' do
      stub_request(:get, /latest-posts$/).to_return({body: read_file('pages/home')})
      page = application.find('/latest-posts', context)
      expect(page).to be_kind_of(Page)
      expect(page.model).to be_kind_of(Document)
      expect(page.model['title']).to eq('Page title')
    end

    it 'should not find a page for invalid url' do
      stub_request(:get, /invalid$/).to_return({status: 404})
      page = application.find('/invalid', context)
      expect(page).to be_nil
    end

  end

  context 'model slugs' do
    it 'should find a page with model' do
      stub_request(:get, /posts\/slug\/my-first-blog-post$/).to_return({body: {document: 'document'}.to_json})
      stub_request(:get, /pages\/model\/posts$/).to_return({body: read_file('pages/home')})
      page = application.find('/posts/my-first-blog-post', context)
      expect(page).to be_kind_of(Page)
      expect(page.model).to be_kind_of(Document)
    end

    it 'should not find a page for invalid slug' do
      stub_request(:get, /posts\/slug\/invalid-blog-post$/).to_return({status: 404})
      page = application.find('/posts/invalid-blog-post', context)
      expect(page).to be_nil
    end
  end
end