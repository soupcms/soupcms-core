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
          data = recipe.execute
          raise "Error while fetching recipe data: #{data['error']}" if data.is_a?(Hash) && data['error']
          @page_module.data[return_object_name] = data
          data
        end

      end

    end
  end
end
