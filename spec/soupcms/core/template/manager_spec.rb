require 'spec_helper'

describe SoupCMS::Core::Template::Manager do

  let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }
  let(:manager) { SoupCMS::Core::Template::Manager.new }

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
    stub_request(:get,/templates\?filters%5B%5D=kind&filters%5B%5D=template_name&filters%5B%5D=type&kind=module&template_name=bootstrap\/invalid\-module&type=slim$/).to_return( { status: 404 } )
    template = manager.find_module(context,'bootstrap/invalid-module','slim')
    expect(template).to be_nil
  end
end