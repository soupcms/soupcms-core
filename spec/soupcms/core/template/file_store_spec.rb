require 'spec_helper'

describe SoupCMS::Core::Template::FileStore do

  let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }

  let(:store) { SoupCMS::Core::Template::FileStore.new(SoupCMS::Core::Template::Manager::DEFAULT_TEMPLATE_DIR) }

  it 'should return file content when file exist' do
    template = store.find_template(context,'bootstrap/page-header','slim', 'module')
    expect(template).not_to be_nil
    expect(template.length).to be > 100
  end

  it 'should return nil when file does not exist' do
    template = store.find_template(context,'bootstrap/invalid-module','slim', 'module')
    expect(template).to be_nil
  end

  it 'should return file without kind' do
    template = store.find_template(context,'partial/system/module-wrapper','slim')
    expect(template).not_to be_nil
    expect(template.length).to be > 100
  end
end