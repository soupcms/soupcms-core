module SoupCMS
  module Core
    module Model


      class CdnConnectResponsiveImage < ResponsiveImage

        def retina_size(size)
          size.concat(',x_2')
        end

        def build_url(size, image)
          url = File.join(base_url,image)
          size ? url.concat("?#{build_params(size)}") : url
        end

        def build_params(size)
          params = size.gsub('_','=').gsub(',','&')
          params.concat("&#{image_hash['params']}") if image_hash['params']
          params.concat('&mode=max') unless params.include?('mode=')
          params
        end

        def base_url
          image_hash['base_url']
        end

      end


    end
  end
end

