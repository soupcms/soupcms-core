require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageArea do

  let (:application) { Application.new('soupcms-test') }
  let (:context) { RequestContext.new(application) }

  context 'with one module' do
    let(:page_area) { SoupCMS::Core::Model::Page.new(read_json('pages/single_module'), context).areas['header'] }

    it { expect(page_area.modules).to be_kind_of(Array) }
    it { expect(page_area.modules.size).to eq(1) }
    it { expect(page_area.modules[0]).to be_kind_of(PageModule) }

    it { expect(html(page_area.render_area)).to have_text('h1','Tech stuff that matters') }

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

end