require 'faraday'
require 'rack/cache'
require 'faraday_middleware'

module SoupCMS
  module Core
    module Utils


      class HttpClient

        @@conn = Faraday.new do |faraday|
          faraday.use FaradayMiddleware::RackCompatible, Rack::Cache::Context,
                      :metastore   => 'heap:/',
                      :entitystore => 'heap:/',
                      :verbose => true,
                      :ignore_headers => %w[Set-Cookie X-Content-Digest]

          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end

        def get(url)
          @@conn.get url
        end

      end



    end
  end
end

