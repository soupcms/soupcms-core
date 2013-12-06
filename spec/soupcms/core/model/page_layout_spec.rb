require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageLayout do

  let(:page) do
    page_with_layout = <<-json
    {
      "title": "Tech stuff that matters",
      "layout": {
          "type": "slim",
          "name": "bootstrap/default"
      }
    }
    json
    Page.new(JSON.parse(page_with_layout))
  end

  context 'render default slim layout template' do
    let(:layout) do
      PageLayout.new(page['layout'], page)
    end

    it { expect(html(layout.render)).to have_title('Tech stuff that matters') }
    it { expect(layout.javascript).to be_nil }
    it { expect(layout.stylesheet).to be_nil }

  end

end