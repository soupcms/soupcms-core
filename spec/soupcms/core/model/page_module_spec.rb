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
                        "title": "Tech stuff that matters 1",
                    },
                    "return": "data"
                }
            ],
            "template": {
                "type": "slim",
                "name": "jumbotron"
            }
        }
      json
      PageModule.new(JSON.parse(module_json), page)
    end


  end

  context 'multiple inline recipe with jumbotron template' do
    let(:page_module) do
      module_json = <<-json
        {
            "recipes": [
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters 1",
                    },
                    "return": "data"
                },
                {
                    "type": "inline",
                    "data": {
                        "title": "Tech stuff that matters 2",
                    },
                    "return": "data"
                }
            ],
            "template": {
                "type": "slim",
                "name": "jumbotron"
            }
        }
      json
      PageModule.new(JSON.parse(module_json), page)
    end

  end


end