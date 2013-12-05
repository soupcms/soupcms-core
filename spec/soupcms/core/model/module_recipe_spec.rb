require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::ModuleRecipe do

  context 'inline recipe' do
    let(:page) { page = Page.new({}) }
    let(:recipe) do
      recipe_json = <<-recipe_json
      {
          "type": "inline",
          "data": {
              "title": "Tech stuff that matters"
          },
          "return": "jumbotron"
      }
      recipe_json
      ModuleRecipe.new(JSON.parse(recipe_json), page)
    end

    it 'return data retrieved by the recipe' do
      expect(recipe.execute['title']).to eq('Tech stuff that matters')
    end

    it 'should set data in the page with return object name' do
      recipe.execute
      expect(page.data['jumbotron']['title']).to eq('Tech stuff that matters')
    end

  end


end