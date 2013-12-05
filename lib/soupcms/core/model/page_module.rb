module SoupCMS
  module Core
    module Model

      class PageModule

        def initialize(module_hash, page)
          @module_hash = module_hash
          @page = page
        end

        def render
          recipes.each { |recipe| recipe.execute }
          <<-response
      <html>
        <head> <title>Page title</title>  </head>
        <body> Yes this works..... </body>
      </html>
          response
        end

        def recipes
          @recipes ||= @module_hash['recipes'].collect { |recipes_hash| ModuleRecipe.new(recipes_hash, @page) }
        end


      end


    end
  end
end