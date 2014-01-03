require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageModule do

  let (:application) { SoupCMS::Core::Model::Application.new('soupcms-test','soupcms-test','http://localhost:9292/api/soupcms-test') }
  let (:context) { RequestContext.new(application) }
  let(:page) { Page.new({'title' => 'Page title'}, context) }
  let(:page_area) { PageArea.new({},page) }

  context 'single inline recipe with page-header template' do
    let(:page_module) do
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
      PageModule.new(JSON.parse(module_json), page_area)
    end

    it { expect(html(page_module.render_module)).to have_text('//h1','Tech stuff that matters') }
    #it { expect(html(page_module.render_module)).to have_attribute('div.module','data-module-name','Tech stuff that matters') }

  end

  context 'multiple inline recipe with page-header template' do
    let(:page_module) do
      module_json = <<-json
        {
            "recipes": [
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters 1"
                    },
                    "return": "page-header"
                },
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters 2"
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
      PageModule.new(JSON.parse(module_json), page_area)
    end

    it { expect(html(page_module.render_module)).to have_text('h1','Tech stuff that matters 2') }

  end

  context 'no recipe' do
    let(:page_module) do
      module_json = <<-json
        {
            "template": {
                "type": "slim",
                "name": "meta/page-title"
            }
        }
      json
      PageModule.new(JSON.parse(module_json), page_area)
    end

    it { expect(html(page_module.render_module)).to have_title('Page title - soupcms-test') }
  end


end