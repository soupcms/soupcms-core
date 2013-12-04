require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::Page do

  context 'render' do

    let (:page) do
      SoupCMS::Core::Model::Page.new(read_json('pages/home'))
    end

    context 'page with header module' do
      it { expect(html(page.render)).to have_title('Page title')  }

    end

  end
end