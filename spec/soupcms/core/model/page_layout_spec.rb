require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageLayout do

  let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }

  let(:page) do
    page_with_layout = <<-json
    {
      "title": "Tech stuff that matters",
      "layout": {
        "type": "slim",
        "name": "bootstrap/full-width"
      },
      "areas" : [
        {
          "name": "meta",
          "modules" :[
            {
              "template": {
                "type": "slim",
                "name": "meta/page-title"
              }
            }
          ]
        }
      ]
    }
    json
    Page.new(JSON.parse(page_with_layout), context)
  end

  context 'render default slim layout template' do
    let(:layout) do
      PageLayout.new(page['layout'], page)
    end

    it do
      page.render_page
      expect(html(layout.render)).to have_title('Tech stuff that matters - soupCMS Test')
    end
    it { expect(page.javascripts).to include('layout/bootstrap/full-width/full-width.js') }
    it { expect(page.stylesheets).to include('layout/bootstrap/full-width/full-width.css') }
  end

end