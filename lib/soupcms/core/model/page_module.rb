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

        def render_module
          recipes.collect { |recipe| recipe.execute }
          module_html = template.render
          @html = Tilt.new(module_wrapper_template).render(self, {html: module_html})
        end

        def javascript
          template.javascript
        end

        def stylesheet
          template.stylesheet
        end

        def rimg(image, desktop, tablet, mobile)
          image = SoupCMS::Core::Model::ResponsiveImage.build(image, desktop, tablet, mobile)
          Tilt.new("#{SoupCMSApp.config.template_dir}/system/responsive-img.slim").render(image, {'page_module' => self})
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