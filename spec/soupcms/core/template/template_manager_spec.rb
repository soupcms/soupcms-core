require 'spec_helper'

describe SoupCMS::Core::Template::TemplateManager do

  let (:application) { SoupCMS::Core::Model::Application.new('soupcms-test') }
  let (:context) { SoupCMS::Core::Model::RequestContext.new(application) }

  let(:manager) do
    mgr = SoupCMS::Core::Template::TemplateManager.new
    mgr.register(SoupCMS::Core::Template::TemplateFileStore.new(SoupCMS::Core::ConfigDefaults::TEMPLATE_DIR))
    mgr.register(SoupCMS::Core::Template::TemplateSoupCMSApiStore)
    mgr
  end

  it 'should return tilt parsed template when file exist' do
    template = manager.find_module(context,'bootstrap/page-header','slim')
    expect(template).not_to be_nil
    expect(template).to be_kind_of(Slim::Template)
  end

  #it 'requesting multiple time same template should return same object' do
  #  template1 = manager.find_module(context,'bootstrap/page-header','slim')
  #  template2 = manager.find_module(context,'bootstrap/page-header','slim')
  #  expect(template1).to eq(template2)
  #end

  it 'should return nil when file does not exist' do
    stub_request(:get,/templates\?filters%5B0%5D=kind&filters%5B1%5D=template_name&filters%5B2%5D=type&kind=%22module%22&template_name=%22bootstrap\/invalid\-module%22&type=%22slim%22$/).to_return( { status: 404 } )
    template = manager.find_module(context,'bootstrap/invalid-module','slim')
    expect(template).to be_nil
  end
end