module SoupCMS
  module Core
    module Model

      class ResponsiveImage

        def self.register(source,klass)
          @@providers ||= {}
          @@providers[source] = klass
        end

        def self.clear_all
          @@providers = {}
        end

        def self.build(responsive_image_hash)
          provider = @@providers[responsive_image_hash[:image]['source']]
          provider.new(responsive_image_hash)
        end

        def initialize(responsive_image_hash)
          @image = responsive_image_hash[:image]
          @desktop = responsive_image_hash[:desktop]
          @tablet = responsive_image_hash[:tablet]
          @mobile = responsive_image_hash[:mobile]
          @html_options = responsive_image_hash[:html_options]
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
          Tilt.new("#{SoupCMS::Core::Config.configs.template_dir}/system/responsive-img.slim").render(self, locals)
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

        def build_url(size,image)
          raise 'implement retina_size method for the provider'
        end

      end


    end
  end
end

