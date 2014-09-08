module SoupCMS
  module Core
    module Model


      class CdnConnectResponsiveImage < ResponsiveImage

        def retina_size(size)
          size.concat(',x_2')
        end

        def build_url(size, image_name)
          url = File.join(base_url,image_name)
          size ? url.concat("?#{build_params(size)}") : url
        end

        def build_params(size)
          params = size.gsub('_','=').gsub(',','&')
          params.concat("&#{image['params']}") if image['params']
          params.gsub!('c=pad','mode=default')
          params.gsub!('c=fit','mode=max')
          params.gsub!('c=fill','mode=crop')
          params.gsub!('c=scale','mode=stretch')
          params.concat('&mode=max') unless params.include?('mode=')
          params
        end

        def base_url
          image['base_url'] || ENV['CDNCONNECT_BASE_URL']
        end

      end


    end
  end
end

