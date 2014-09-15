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

        def build_url(size, image_name)
          size.concat(",#{image['params']}") if image['params']
          size.concat(',c_fit') unless size.include?('c_')
          size ? File.join(base_url,size,image_name) : File.join(base_url,image_name)
        end

        def base_url
          image['base_url'] || @context.application['CLOUDINARY_BASE_URL'] || ENV['CLOUDINARY_BASE_URL']
        end

      end


    end
  end
end

