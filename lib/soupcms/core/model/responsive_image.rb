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

        def self.build(image_hash, desktop, tablet = nil, mobile = nil)
          provider = @@providers[image_hash['source']]
          provider.new(image_hash, desktop, tablet, mobile)
        end

        def initialize(image_hash, desktop, tablet, mobile)
          @image_hash = image_hash
          @desktop = desktop
          @tablet = tablet
          @mobile = mobile
        end

        attr_reader :image_hash

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

        protected

        def desktop_size
          @desktop
        end

        def desktop_image
          @image_hash['desktop']
        end

        def tablet_size
          @tablet || @desktop
        end

        def tablet_image
          @image_hash['tablet'] || desktop_image
        end

        def mobile_size
          @mobile || @tablet || @desktop
        end

        def mobile_image
          @image_hash['mobile'] || tablet_image || desktop_image
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

