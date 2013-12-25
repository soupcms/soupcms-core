module SoupCMS
  module Core
    module Model

      class PageModule
        include Sprockets::Helpers
        include SoupCMS::Core::Utils::RenderPartials

        def initialize(module_hash, page_area)
          @module_hash = module_hash
          @page_area = page_area
          @data = {}
        end

        attr_reader :page_area, :data, :html

        def page
          page_area.page
        end

        def context
          page.context
        end

        def render_module
          recipes.collect { |recipe| recipe.execute }
          module_html = template.render
          @html = module_wrapper_template.render(self, {html: module_html})
        end

        def javascript
          template.javascript
        end

        def stylesheet
          template.stylesheet
        end

        def rimg(responsive_image_hash)
          SoupCMSCore.config.responsive_image.build(context,responsive_image_hash).render_image('page_module' => self)
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
          SoupCMSCore.config.template_manager.find(context,'partial/system/module-wrapper.slim')
        end

      end


    end
  end
end