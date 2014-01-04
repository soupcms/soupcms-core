require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::ModuleRecipe do

  context 'inline recipe' do
    let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }
    let(:page) { Page.new({}, context) }
    let(:page_module) { PageModule.new({},page) }
    let(:recipe) do
      recipe_json = <<-recipe_json
      {
          "type": "inline",
          "data": {
              "title": "Tech stuff that matters"
          },
          "return": "page-header"
      }
      recipe_json
      ModuleRecipe.new(JSON.parse(recipe_json), page_module)
    end

    it 'return data retrieved by the recipe' do
      expect(recipe.execute['title']).to eq('Tech stuff that matters')
    end

    it 'should set data in the page with return object name' do
      recipe.execute
      expect(page_module.data['page-header']['title']).to eq('Tech stuff that matters')
    end

  end


end