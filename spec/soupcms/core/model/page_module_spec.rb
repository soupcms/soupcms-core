require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageModule do

  let(:page) { Page.new({'title' => 'Page title'}) }
  let(:page_area) { PageArea.new({},page) }

  context 'single inline recipe with jumbotron template' do
    let(:page_module) do
      module_json = <<-json
        {
            "recipes": [
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters"
                    },
                    "return": "jumbotron"
                }
            ],
            "template": {
                "type": "slim",
                "name": "bootstrap/jumbotron"
            }
        }
      json
      PageModule.new(JSON.parse(module_json), page_area)
    end

    it { expect(html(page_module.render)).to have_text('//h1','Tech stuff that matters') }
    #it { expect(html(page_module.render)).to have_attribute('div.module','data-module-name','Tech stuff that matters') }

  end

  context 'multiple inline recipe with jumbotron template' do
    let(:page_module) do
      module_json = <<-json
        {
            "recipes": [
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters 1"
                    },
                    "return": "jumbotron"
                },
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters 2"
                    },
                    "return": "jumbotron"
                }
            ],
            "template": {
                "type": "slim",
                "name": "bootstrap/jumbotron"
            }
        }
      json
      PageModule.new(JSON.parse(module_json), page_area)
    end

    it { expect(html(page_module.render)).to have_text('h1','Tech stuff that matters 2') }

  end

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

  it { expect(html(page_module.render)).to have_title('Page title') }
  context 'no recipe' do

  end


end