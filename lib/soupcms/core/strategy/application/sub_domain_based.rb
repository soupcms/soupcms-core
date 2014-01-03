module SoupCMS
  module Core
    module Strategy
      module Application

        class SubDomainBased < ApplicationStrategy

          def app_name
            request.host.match(/^[\w\-]*\./)[0].gsub('.','')
          end

          def path
            request.path[1..-1]
          end

          def soupcms_api_url
            "#{request.base_url}/api"
          end
        end

      end
    end
  end
end

