require 'spec_helper'

describe SoupCMS::Core::Model::Application do

  it 'should return same application when called again' do
    test1 = SoupCMS::Core::Model::Application.get('test')
    test2 = SoupCMS::Core::Model::Application.get('test')
    expect(test1).to eq(test2)
  end
end