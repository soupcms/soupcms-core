module SoupCMS
  module Core
    module Model

      class PageModule

        def initialize(module_hash, page_area)
          @module_hash = module_hash
          @page_area = page_area
          @data = {}
        end

        attr_reader :page_area, :data, :html

        def page
          page_area.page
        end

        def render
          recipes.collect { |recipe| recipe.execute }
          module_html = template.render
          @html = Tilt.new(module_wrapper_template,{disable_escape: true}).render(self, {html: module_html})
        end

        def javascript
          template.javascript
        end

        def stylesheet
          template.stylesheet
        end

        private

        def recipes
          recipes_hash = @module_hash['recipes'] || []
          @recipes ||= recipes_hash.collect { |recipes_hash| ModuleRecipe.new(recipes_hash, self) }
        end

        def template
          @template ||= ModuleTemplate.new(@module_hash['template'], self)
        end

        def module_wrapper_template
          "#{SoupCMSApp.config.template_dir}/system/module_wrapper.slim"
        end

      end


    end
  end
end