require 'faraday'
require 'json'

module SoupCMS
  module Core
    module Data

      class Service < Base

        def initialize(app_name)
          super(app_name)
          @conn = Faraday.new(:url => "http://localhost:9292/api/#{@app_name}") do |faraday|
            faraday.request :url_encoded
            faraday.adapter Faraday.default_adapter
          end
        end

        def find_by_key(model, key, value)
          url = "#{model}/#{key}/#{value}"
          response = @conn.get(url)
          return (JSON.parse(response.body)) if response.status == 200
        end

      end

    end
  end
end
