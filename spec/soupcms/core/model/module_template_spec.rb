require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::ModuleTemplate do

  let(:page) do
    page = Page.new({})
    page.data['jumbotron'] = { 'title' => 'Tech stuff that matters' }
    page
  end

  context 'render slim jumbotron template' do
    let(:module_template) do
      module_template = <<-json
        {
          "type": "slim",
          "name": "jumbotron"
        }
      json
      ModuleTemplate.new(JSON.parse(module_template), page)
    end

    it { expect(html(module_template.render)).to have_text('h1','Tech stuff that matters') }


  end

end