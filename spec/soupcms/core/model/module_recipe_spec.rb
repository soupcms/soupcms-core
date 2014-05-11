require 'spec_helper'
require 'json'

include SoupCMS::Core::Model

describe SoupCMS::Core::Model::ModuleRecipe do

  context 'inline recipe' do
    let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }
    let(:page) { Page.new({}, context) }
    let(:page_module) { PageModule.new({},page) }

    describe 'recipe without get' do
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

    describe 'recipe with get' do
      let(:recipe) do
        recipe_json = <<-recipe_json
      {
          "type": "inline",
          "data": {
              "title": "Tech stuff that matters"
          },
          "get": "result['title']",
          "return": "page-header"
      }
        recipe_json
        ModuleRecipe.new(JSON.parse(recipe_json), page_module)
      end

      it 'should get data requested from the result and map to return variable' do
        expect(recipe.execute).to eq('Tech stuff that matters')
      end
    end


  end


end