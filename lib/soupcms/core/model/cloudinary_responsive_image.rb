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
          size.concat(",#{image_hash['params']}") if image_hash['params']
          size.concat(',c_fit') unless size.include?('c_')
          size ? File.join(base_url,size,image) : File.join(base_url,image)
        end

        def base_url
          image_hash['base_url']
        end

      end


    end
  end
end

