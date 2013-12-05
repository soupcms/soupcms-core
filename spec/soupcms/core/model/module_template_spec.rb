require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::ModuleTemplate do

  let(:page) { Page.new({}) }
  let(:page_module) do
    page_module = PageModule.new({}, page)
    page_module.data['jumbotron'] = { 'title' => 'Tech stuff that matters' }
    page_module
  end

  context 'render slim jumbotron template' do
    let(:module_template) do
      module_template = <<-json
        {
          "type": "slim",
          "name": "bootstrap/jumbotron"
        }
      json
      ModuleTemplate.new(JSON.parse(module_template), page_module)
    end

    it { expect(html(module_template.render)).to have_text('h1','Tech stuff that matters') }


  end

end