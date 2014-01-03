require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageLayout do

  let (:application) { SoupCMS::Core::Model::Application.new('soupcms-test','soupcms-test','http://localhost:9292/api/soupcms-test') }
  let (:context) { RequestContext.new(application) }

  let(:page) do
    page_with_layout = <<-json
    {
      "title": "Tech stuff that matters",
      "layout": {
        "type": "slim",
        "name": "bootstrap/default"
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
      expect(html(layout.render)).to have_title('Tech stuff that matters - soupcms-test')
    end
    it { expect(page.javascripts).to include('layout/bootstrap/default/default.js') }
    it { expect(page.stylesheets).to include('layout/bootstrap/default/default.css') }
  end

end