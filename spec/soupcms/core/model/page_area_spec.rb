require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageArea do

  let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }

  context 'with one module' do
    let(:page_area) { SoupCMS::Core::Model::Page.new(read_json('pages/single_module'), context).areas['header'] }

    it { expect(page_area.modules).to be_kind_of(Array) }
    it { expect(page_area.modules.size).to eq(1) }
    it { expect(page_area.modules[0]).to be_kind_of(PageModule) }

    it { expect(html(page_area.render_area)).to have_text('h1','Tech stuff that matters') }
    it { expect(html(page_area.render_area)).to have_node('.module') }
    it { expect(html(page_area.render_area)).to have_attribute("//div[@class='module']",'data-area-name','header') }

  end

  context 'with multiple modules' do
    let(:page_area) { SoupCMS::Core::Model::Page.new(read_json('pages/multiple_module'), context).areas['header'] }

    it { expect(page_area.modules).to be_kind_of(Array) }
    it { expect(page_area.modules.size).to eq(2) }
    it { expect(page_area.modules[0]).to be_kind_of(PageModule) }
    it { expect(page_area.modules[1]).to be_kind_of(PageModule) }

    it { expect(html(page_area.render_area)).to have_text('h1','title 1',0) }
    it { expect(html(page_area.render_area)).to have_text('h1','title 2',1) }

  end

  context 'should not add wrapper div when area name is head' do
    let(:page_area) { SoupCMS::Core::Model::Page.new(read_json('pages/multiple_area'), context).areas['meta'] }

    it { expect(html(page_area.render_area)).to have_text('title','Page title - soupCMS Test') }
    it { expect(html(page_area.render_area)).to_not have_node('.module') }

  end

  context 'module reference is provided' do
    let(:page_area) { SoupCMS::Core::Model::Page.new(read_json('pages/reference_module'), context).areas['header'] }

    it 'should resolve the module reference' do
      module_json = <<-json
        {
            "recipes": [
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters"
                    },
                    "return": "page-header"
                }
            ],
            "template": {
                "type": "slim",
                "name": "bootstrap/page-header"
            }
        }
      json
      stub_request(:get, /modules\/doc_id\/navigation/).to_return({body: module_json})

      expect(page_area.modules[0]).to be_kind_of(PageModule)
      expect(page_area.modules[0].module_hash).to eq(JSON.parse(module_json))
    end

  end

end