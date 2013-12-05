module SoupCMS
  module Core
    module Model

      class PageModule

        def initialize(module_hash, page)
          @module_hash = module_hash
          @page = page
          @data = {}
        end

        attr_reader :page, :data

        def render
          recipes.collect { |recipe| recipe.execute }
          template.render
        end

        private

        def recipes
          @recipes ||= @module_hash['recipes'].collect { |recipes_hash| ModuleRecipe.new(recipes_hash, self) }
        end

        def template
          ModuleTemplate.new(@module_hash['template'], self)
        end


      end


    end
  end
end