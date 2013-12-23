require 'spec_helper'

describe SoupCMS::Core::Template::TemplateSoupCMSApiStore do

  let (:application) { SoupCMS::Core::Model::Application.new('soupcms-test') }
  let (:context) { SoupCMS::Core::Model::RequestContext.new(application) }
  let(:store) { SoupCMS::Core::Template::TemplateSoupCMSApiStore.new }

  it 'should return file content when file exist' do
    response_json = <<-json
    [ { "template" : "h1 Getting Started" }]
    json
    stub_request(:get,/templates\?filters%5B0%5D=kind&filters%5B1%5D=template_name&filters%5B2%5D=type&kind=%22module%22&template_name=%22bootstrap\/page\-header%22&type=%22slim%22$/).to_return( { body: response_json} )
    template = store.find(context, 'bootstrap/page-header', 'slim', 'module')
    expect(template).not_to be_nil
    expect(template.length).to be > 10
  end

  it 'should return nil when file does not exist' do
    stub_request(:get,/templates\?filters%5B0%5D=kind&filters%5B1%5D=template_name&filters%5B2%5D=type&kind=%22module%22&template_name=%22bootstrap\/invalid\-module%22&type=%22slim%22$/).to_return( { status: 404 } )
    template = store.find(context, 'bootstrap/invalid-module', 'slim', 'module')
    expect(template).to be_nil
  end

  it 'should return file without kind' do
    response_json = <<-json
    [ { "template" : "h1 Getting Started" }]
    json
    stub_request(:get,/templates\?filters%5B0%5D=kind&filters%5B1%5D=template_name&filters%5B2%5D=type&template_name=%22partial\/system\/module\-wrapper%22&type=%22slim%22$/).to_return( { body: response_json} )
    template = store.find(context, 'partial/system/module-wrapper', 'slim')
    expect(template).not_to be_nil
    expect(template.length).to be > 10
  end
end