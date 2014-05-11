module SoupCMS
  module Core
    module Model


      class ModuleRecipe

        def initialize(recipe_hash,page_module)
          @recipe_hash = recipe_hash
          @page_module = page_module
        end

        def return_object_name
          @recipe_hash['return']
        end

        def recipe
          @recipe ||= SoupCMSCore.config.recipes[@recipe_hash['type']].new(@recipe_hash,@page_module)
        end

        def execute
          result = recipe.execute
          raise "Error while fetching recipe data: #{result['error']}" if result.is_a?(Hash) && result['error']
          result = @recipe_hash['get'] ? eval(@recipe_hash['get']) : result
          @page_module.data[return_object_name] = result
          result
        end

      end

    end
  end
end
