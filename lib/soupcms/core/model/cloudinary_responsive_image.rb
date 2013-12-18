module SoupCMS
  module Core
    module Model


      class CloudinaryResponsiveImage < ResponsiveImage

        def retina_size(size)
          size.split(',').collect { |part|
            attr_parts = part.split('_')
            if attr_parts[0] == 'w' || attr_parts[0] == 'h'
              attr_parts[1] = attr_parts[1].to_i * 2
            end
            attr_parts.join('_')
          }.join(',')
        end

        def build_url(size, image)
          size.concat(',c_fill') unless size.include?('c_')
          size ? "#{base_url}/#{size}/#{image}" : "#{base_url}/#{image}"
        end

        def base_url
          image_hash['base_url']
        end

      end


    end
  end
end

