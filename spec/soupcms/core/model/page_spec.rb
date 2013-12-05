require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::Page do

  context 'with one area' do
    let((:page)) { SoupCMS::Core::Model::Page.new(read_json('pages/single_module')) }

    it { expect(page.areas).to be_kind_of(Hash) }
    it { expect(page.areas.size).to eq(1) }
    it { expect(page.areas['header']).to be_kind_of(PageArea)  }


  end

  context 'with multiple area' do
    let((:page)) { SoupCMS::Core::Model::Page.new(read_json('pages/multiple_area')) }

    it { expect(page.areas).to be_kind_of(Hash) }
    it { expect(page.areas.size).to eq(2) }
    it { expect(page.areas['header']).to be_kind_of(PageArea)  }
    it { expect(page.areas['body']).to be_kind_of(PageArea)  }

  end
end