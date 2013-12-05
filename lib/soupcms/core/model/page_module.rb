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
          template.render
        end

        def recipes
          @recipes ||= @module_hash['recipes'].collect { |recipes_hash| ModuleRecipe.new(recipes_hash, @page) }
        end

        def template
          ModuleTemplate.new(@module_hash['template'], @page)
        end


      end


    end
  end
end