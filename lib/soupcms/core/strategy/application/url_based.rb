module SoupCMS
  module Core
    module Strategy
      module Application

        class UrlBased < ApplicationStrategy

          def initialize(request)
            @request = request
          end

          attr_reader :request

          def app_name
            url_parser = request.path.match(/\/[\w\.\-]*\//)
            url_parser[0].gsub('/', '') if url_parser
          end

          def path
            url_parser = request.path.match(/\/[\w\.\-]*\//)
            url_parser.post_match if url_parser
          end

          def soupcms_api_url
            "#{request.base_url}/api/#{app_name}"
          end

        end

      end
    end
  end
end

