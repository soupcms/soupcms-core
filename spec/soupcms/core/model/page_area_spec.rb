require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageArea do

  context 'with one module' do
    let(:page_area) { SoupCMS::Core::Model::Page.new(read_json('pages/single_module')).areas['header'] }

    it { expect(page_area.modules).to be_kind_of(Array) }
    it { expect(page_area.modules.size).to eq(1) }
    it { expect(page_area.modules[0]).to be_kind_of(PageModule) }

  end

  context 'with multiple modules' do
    let(:page_area) { SoupCMS::Core::Model::Page.new(read_json('pages/multiple_module')).areas['header'] }

    it { expect(page_area.modules).to be_kind_of(Array) }
    it { expect(page_area.modules.size).to eq(2) }
    it { expect(page_area.modules[0]).to be_kind_of(PageModule) }
    it { expect(page_area.modules[1]).to be_kind_of(PageModule) }

  end

end