module SoupCMS
  module Core
    module Model


      class SimpleImage < ResponsiveImage

        def initialize(context, responsive_image_hash)
          @url = responsive_image_hash[:image]['url']
          @html_options = responsive_image_hash[:html_options]
          @context = context
        end

        attr_reader :url

        def render_image(locals = {})
          SoupCMSCore.config.template_manager.new.find(@context, 'partial/system/img.slim').render(self, locals)
        end


      end


    end
  end
end

