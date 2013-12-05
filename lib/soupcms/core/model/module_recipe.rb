module SoupCMS
  module Core
    module Model


      class ModuleRecipe

        def initialize(recipe_hash,page)
          @recipe_hash = recipe_hash
          @page = page
        end

        def return_object_name
          @recipe_hash['return']
        end

        def recipe
          SoupCMSApp.config.recipes[@recipe_hash['type']].new(@recipe_hash,@page)
        end

        def execute
          data = recipe.execute
          @page.data[return_object_name] = data
          data
        end

      end

    end
  end
end
