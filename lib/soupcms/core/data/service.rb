require 'faraday'
require 'json'

module SoupCMS
  module Core
    module Data

      class Service < Base

        def connection
          @connection ||= Faraday.new(url: "#{application.soup_cms_api_host_url}/api/#{application.name}") do |faraday|
            faraday.request :url_encoded
            faraday.adapter Faraday.default_adapter
          end
        end

        def find_by_key(model, key, value)
          url = "#{model}/#{key}/#{value}"
          response = connection.get(url)
          return (JSON.parse(response.body)) if response.status == 200
        end

        def find(model_name, filters = {})
          url = SoupCMS::Core::Utils::UrlBuilder.build(model_name, filters)
          response = connection.get(url)
          return JSON.parse(response.body) if response.status == 200
          []
        end

        def fetch_by_url(url)
          response = connection.get(url)
          JSON.parse(response.body) if response.status == 200
        end

      end

    end
  end
end
