require 'spec_helper'

describe SoupCMS::Core::Template::TemplateFileStore do

  let(:store) { SoupCMS::Core::Template::TemplateFileStore.new(SoupCMS::Core::ConfigDefaults::TEMPLATE_DIR) }

  it 'should return file content when file exist' do
    template = store.find('module','bootstrap/page-header','slim')
    expect(template).not_to be_nil
    expect(template.length).to be > 100
  end

  it 'should return nil when file does not exist' do
    template = store.find('module','bootstrap/invalid-module','slim')
    expect(template).to be_nil
  end
end