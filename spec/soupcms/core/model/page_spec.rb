require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::Page do

  let (:context) { RequestContext.new(application) }

  context 'with one area' do
    let(:page) { SoupCMS::Core::Model::Page.new(read_json('pages/single_module'), context) }

    it { expect(page.areas).to be_kind_of(Hash) }
    it { expect(page.areas.size).to eq(1) }
    it { expect(page.areas['header']).to be_kind_of(PageArea)  }

    it { expect(page.javascripts.size).to be >= 2 }
    it { expect(page.stylesheets.size).to be >= 2 }
    it { expect(page.javascripts).to include('module/bootstrap/page-header/page-header.js') }
    it { expect(page.stylesheets).to include('module/bootstrap/page-header/page-header.css') }

  end

  context 'with multiple area' do
    let((:page)) { SoupCMS::Core::Model::Page.new(read_json('pages/multiple_area'), context) }

    it { expect(page.areas).to be_kind_of(Hash) }
    it { expect(page.areas.size).to eq(2) }
    it { expect(page.areas['header']).to be_kind_of(PageArea)  }
    it { expect(page.areas['body']).to be_kind_of(PageArea)  }

    context 'duplicate modules js and css should be removed' do
      it { expect(page.javascripts.size).to be >= 2 }
      it { expect(page.stylesheets.size).to be >= 2 }
      it { expect(page.javascripts).to include('module/bootstrap/page-header/page-header.js') }
      it { expect(page.stylesheets).to include('module/bootstrap/page-header/page-header.css') }
    end

  end
end