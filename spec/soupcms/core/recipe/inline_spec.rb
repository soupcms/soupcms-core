require 'spec_helper'

describe SoupCMS::Core::Recipe::Inline do

  let(:recipe) { SoupCMS::Core::Recipe::Inline.new({ 'data' => { 'title' => 'my title'} },nil) }

  it 'should return data' do
    expect(recipe.execute).to eq({ 'title' => 'my title'})
  end
end