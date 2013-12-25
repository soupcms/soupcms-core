require 'net/http'

module SoupCMS
  module Core
    module Utils


      class HttpClient

        def self.connection=(connection)
          @@connection = connection
        end

        def connection
          @@connection ||= Net::HTTP
        end

        def get(url, params = {})
          uri = URI(url)
          uri.query = SoupCMS::Core::Utils::ParamsHash.new.merge!(params).to_query unless params.nil? || params.empty?
          response = connection.get uri
          if response.nil? || response.kind_of?(String)
            response
          elsif response.status == 200
            response.body
          end
        end

      end


    end
  end
end

