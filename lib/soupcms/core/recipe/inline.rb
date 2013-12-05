module SoupCMS
  module Core
    module Recipe

      class Inline

        def initialize(recipe_hash, page_module)
          @recipe_hash = recipe_hash
          @page_module = page_module
        end

        def execute
          @recipe_hash['data']
        end

      end

    end
  end
end
