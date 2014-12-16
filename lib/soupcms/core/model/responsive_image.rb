module SoupCMS
  module Core
    module Model

      class ResponsiveImage

        def self.providers
          @@providers ||= {
              'cloudinary' => SoupCMS::Core::Model::CloudinaryResponsiveImage,
              'cdnconnect' => SoupCMS::Core::Model::CdnConnectResponsiveImage
          }
        end

        def self.register(source, klass)
          providers[source] = klass
        end

        def self.clear_all
          @@providers = {}
        end

        def self.build(context, responsive_image_hash)
          source = responsive_image_hash[:image]['source']
          provider = source ? providers[source] : SoupCMS::Core::Model::SimpleImage
          provider.new(context, responsive_image_hash)
        end

        def initialize(context, responsive_image_hash)
          @image = responsive_image_hash[:image]
          @desktop_size_params = responsive_image_hash[:desktop]
          @tablet_size_params = responsive_image_hash[:tablet]
          @mobile_size_params = responsive_image_hash[:mobile]
          @html_options = responsive_image_hash[:html_options] || {}
          @html_options.merge!(@image['html_options']) if @image && @image['html_options']
          @context = context
        end

        attr_reader :image

        def desktop_url
          build_url(desktop_size, desktop_image)
        end

        alias_method :url, :desktop_url

        def open_graph_url
          url.include?('http:') ? url.sub('.svg','.png') : "http:#{url}".sub('.svg','.png')
        end

        def tablet_url
          build_url(tablet_size, tablet_image)
        end

        def mobile_url
          build_url(mobile_size, mobile_image)
        end

        def desktop_retina_url
          build_url(retina_size(desktop_size), desktop_image)
        end

        def tablet_retina_url
          build_url(retina_size(tablet_size), tablet_image)
        end

        def mobile_retina_url
          build_url(retina_size(mobile_size), mobile_image)
        end

        def render_image(locals = {})
          SoupCMSCore.config.template_manager.new.find(@context, 'partial/system/responsive-img.slim').render(self, locals)
        end

        def html_options
          @html_options || {}
        end

        protected

        def desktop_size
          @desktop_size_params
        end

        def desktop_image
          @image['desktop']
        end

        def tablet_size
          @tablet_size_params || @desktop_size_params
        end

        def tablet_image
          @image['tablet'] || desktop_image
        end

        def mobile_size
          @mobile_size_params || @tablet_size_params || @desktop_size_params
        end

        def mobile_image
          @image['mobile'] || tablet_image || desktop_image
        end

        def retina_size(size)
          raise 'implement retina_size method for the provider'
        end

        def build_url(size, image)
          raise 'implement retina_size method for the provider'
        end

      end


    end
  end
end

