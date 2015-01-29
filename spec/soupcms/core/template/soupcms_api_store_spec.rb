require 'spec_helper'

describe SoupCMS::Core::Template::SoupCMSApiStore do

  let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }
  let(:store) { SoupCMS::Core::Template::SoupCMSApiStore.new }

  it 'should return file content when file exist' do
    response_json = <<-json
    [ { "template" : "h1 Getting Started" }]
    json
    stub_request(:get,/templates\?filters%5B%5D=kind&filters%5B%5D=template_name&filters%5B%5D=type&kind=module&template_name=bootstrap\/page\-header&type=slim$/).to_return( { body: response_json} )
    template = store.find_template(context, 'bootstrap/page-header', 'slim', 'module')
    expect(template).not_to be_nil
    expect(template.length).to be > 10
  end

  it 'should return nil when file does not exist' do
    stub_request(:get,/templates\?filters%5B%5D=kind&filters%5B%5D=template_name&filters%5B%5D=type&kind=module&template_name=bootstrap\/invalid\-module&type=slim$/).to_return( { status: 404 } )
    template = store.find_template(context, 'bootstrap/invalid-module', 'slim', 'module')
    expect(template).to be_nil
  end

  it 'should return file without kind' do
    response_json = <<-json
    [ { "template" : "h1 Getting Started" }]
    json
    stub_request(:get,/templates\?filters%5B%5D=template_name&filters%5B%5D=type&template_name=partial\/system\/module\-wrapper&type=slim$/).to_return( { body: response_json} )
    template = store.find_template(context, 'partial/system/module-wrapper', 'slim')
    expect(template).not_to be_nil
    expect(template.length).to be > 10
  end
end