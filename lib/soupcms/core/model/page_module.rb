module SoupCMS
  module Core
    module Model

      class PageModule
        include SoupCMS::Core::Utils::RenderPartials

        def initialize(module_hash, page_area)
          @module_hash = module_hash
          @page_area = page_area
          @data = {}
        end

        attr_reader :page_area, :data, :html, :module_hash

        def page
          page_area.page
        end

        def context
          page.context
        end

        def render_module
          begin
            recipes.each { |recipe| recipe.execute }
            module_html = template.render
            @html = page_area.wrapper? ? module_wrapper_template.render(self, {html: module_html}) : module_html
          rescue => e
            @html = <<-html
<!--
Error while rendering module in area '#{page_area.name}',

Module Hash:
#{JSON.pretty_generate module_hash}

Module Data:
#{JSON.pretty_generate data}

Error:
#{e.backtrace.first}: #{e.message} (#{e.class})
#{e.backtrace.drop(1).map{|s| s }.join("\n")}
-->
            html
          end
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

        def image(image_hash)
          SoupCMSCore.config.responsive_image.build(context,image_hash)
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
          SoupCMSCore.config.template_manager.new.find(context,'partial/system/module-wrapper.slim')
        end

      end


    end
  end
end