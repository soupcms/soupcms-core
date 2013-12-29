module SoupCMS
  module Core
    module Recipe

      class PostProcessor

        def initialize(recipe_hash, page_module)
          @recipe_hash = recipe_hash
          @page_module = page_module
        end

        def execute
          Class.class_eval(@recipe_hash['processor']).new(@recipe_hash, @page_module).execute
        end

      end

    end
  end
end
