require 'spec_helper'

describe SoupCMS::Core::Template::TemplateManager do

  let(:manager) do
    mgr = SoupCMS::Core::Template::TemplateManager.new
    mgr.register(SoupCMS::Core::Template::TemplateFileStore.new(SoupCMS::Core::ConfigDefaults::TEMPLATE_DIR))
    mgr
  end

  it 'should return tilt parsed template when file exist' do
    template = manager.find_module('bootstrap/page-header','slim')
    expect(template).not_to be_nil
    expect(template).to be_kind_of(Slim::Template)
  end

  it 'requesting multiple time same template should return same object' do
    template1 = manager.find_module('bootstrap/page-header','slim')
    template2 = manager.find_module('bootstrap/page-header','slim')
    expect(template1).to eq(template2)
  end

  it 'should return nil when file does not exist' do
    template = manager.find_module('bootstrap/invalid-module','slim')
    expect(template).to be_nil
  end
end