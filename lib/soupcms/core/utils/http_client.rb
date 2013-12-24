require 'faraday'

module SoupCMS
  module Core
    module Utils


      class HttpClient

        def self.connection=(connection)
          @@connection = connection
        end

        def connection
          @@connection ||= Faraday.new { |faraday| faraday.adapter Faraday.default_adapter}
        end

        def get(url, params = {})
          connection.get url, params
        end

      end



    end
  end
end

