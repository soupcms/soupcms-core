require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::PageModule do

  let(:page) { page = Page.new({}) }


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
      PageModule.new(JSON.parse(module_json), page)
    end

    it { expect(html(page_module.render)).to have_text('h1','Tech stuff that matters') }

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
      PageModule.new(JSON.parse(module_json), page)
    end

    it { expect(html(page_module.render)).to have_text('h1','Tech stuff that matters 2') }

  end


end