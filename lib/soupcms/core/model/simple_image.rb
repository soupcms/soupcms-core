module SoupCMS
  module Core
    module Model


      class SimpleImage < ResponsiveImage

        def initialize(context, responsive_image_hash)
          @image = responsive_image_hash[:image]
          @url = @image['url']
          @html_options = responsive_image_hash[:html_options] || {}
          @html_options.merge!(@image['html_options']) if @image && @image['html_options']
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

