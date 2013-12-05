module SoupCMS
  module Core
    module Recipe

      class Inline

        def initialize(recipe_hash, page)
          @recipe_hash = recipe_hash
          @page = page
        end

        def execute
          @recipe_hash['data']
        end

      end

    end
  end
end
