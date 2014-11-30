require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::ModuleTemplate do

  let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }
  let(:page) { Page.new({'title' => 'Page title', 'description' => 'Page description'}, context) }
  let(:page_area) { PageArea.new({},page) }
  let(:page_module) do
    page_module = PageModule.new({}, page)
    page_module.data['page-header'] = { 'headline' => 'Tech stuff that matters' }
    page_module
  end

  context 'render slim page-header template' do
    let(:module_template) do
      module_template = <<-json
        {
          "type": "slim",
          "name": "bootstrap/page-header"
        }
      json
      ModuleTemplate.new(JSON.parse(module_template), page_module)
    end

    it { expect(html(module_template.render)).to have_text('h1','Tech stuff that matters') }
    it { expect(module_template.javascript).to eq('module/bootstrap/page-header/page-header.js') }
    it { expect(module_template.stylesheet).to eq('module/bootstrap/page-header/page-header.css') }
  end

  context 'for stylesheet and javascript does not exists' do
    let(:module_template) do
      module_template = <<-json
        {
          "type": "slim",
          "name": "bootstrap/invalid"
        }
      json
      ModuleTemplate.new(JSON.parse(module_template), page_module)
    end

    it { expect(module_template.javascript).to be_nil }
    it { expect(module_template.stylesheet).to be_nil }
  end

  context 'render inline slim template' do
    let(:module_template) do
      module_template = <<-json
      {
        "type": "slim",
        "template": "title = page['title']\\nmeta name=\\\"description\\\" content=\\\"#{page['description']}\\\""
      }
      json
      ModuleTemplate.new(JSON.parse(module_template), page_module)
    end

    it { expect(html(module_template.render)).to have_text('title','Page title') }
    it { expect(html(module_template.render)).to have_attribute('//meta','content','Page description') }
    it { expect(module_template.javascript).to be_nil }
    it { expect(module_template.stylesheet).to be_nil }
  end

  context 'render multiline inline slim template as array' do
    let(:module_template) do
      module_template = <<-json
      {
        "type": "slim",
        "template": [
              "title = page['title']",
              "meta name=\\\"description\\\" content=\\\"#{page['description']}\\\""
        ]
      }
      json
      ModuleTemplate.new(JSON.parse(module_template), page_module)
    end

    it { expect(html(module_template.render)).to have_text('title','Page title') }
    it { expect(html(module_template.render)).to have_attribute('//meta','content','Page description') }
  end

end