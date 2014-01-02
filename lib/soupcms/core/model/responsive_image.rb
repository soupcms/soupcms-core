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
          provider = providers[responsive_image_hash[:image]['source']]
          provider ? provider.new(context, responsive_image_hash) : SoupCMS::Core::Model::SimpleImage.new(context, responsive_image_hash)
        end

        def initialize(context, responsive_image_hash)
          @image = responsive_image_hash[:image]
          @desktop = responsive_image_hash[:desktop]
          @tablet = responsive_image_hash[:tablet]
          @mobile = responsive_image_hash[:mobile]
          @html_options = responsive_image_hash[:html_options]
          @context = context
        end

        attr_reader :image

        def desktop_url
          build_url(desktop_size, desktop_image)
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
          @desktop
        end

        def desktop_image
          @image['desktop']
        end

        def tablet_size
          @tablet || @desktop
        end

        def tablet_image
          @image['tablet'] || desktop_image
        end

        def mobile_size
          @mobile || @tablet || @desktop
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

