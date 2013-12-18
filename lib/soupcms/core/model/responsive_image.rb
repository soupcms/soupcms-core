module SoupCMS
  module Core
    module Model


      class ResponsiveImage

        def initialize(image_hash, desktop, tablet, mobile)
          @image_hash = image_hash
          @desktop = desktop
          @tablet = tablet
          @mobile = mobile
        end

        attr_reader :image_hash

        def self.build(image_hash, desktop, tablet, mobile)
          #TODO: later support dynamic images from source other than cloudinary based on source in the image_hash
          ResponsiveImage.new(image_hash, desktop, tablet, mobile)
        end

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

        private

        def retina_size(size)
          parts = size.split(',')
          parts = parts.collect do |part|
            attr_parts = part.split('_')
            if attr_parts[0] == 'w' || attr_parts[0] == 'h'
              attr_parts[1] = attr_parts[1].to_i * 2
            end
            attr_parts.join('_')
          end
          parts.join(',')
        end

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
          @image_hash['tablet'] || @image_hash['desktop']
        end

        def mobile_size
          @mobile || @tablet || @desktop
        end

        def mobile_image
          @image_hash['mobile'] || @image_hash['tablet'] || @image_hash['desktop']
        end

        def build_url(size, image)
          size ? "#{base_url}/#{size}/#{image}" : "#{base_url}/#{image}"
        end

        def base_url
          puts image_hash['base_url']
          image_hash['base_url']
        end

      end


    end
  end
end

