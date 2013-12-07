require 'faraday'
require 'json'

module SoupCMS
  module Core
    module Data

      class Service < Base

        def initialize(app_info)
          super(app_info)
          @conn = Faraday.new(:url => "#{SoupCMSApp.config.soupcms_api_host_url}/api/#{@app_info.name}") do |faraday|
            faraday.request :url_encoded
            faraday.adapter Faraday.default_adapter
          end
        end

        def find_by_key(model, key, value)
          url = "#{model}/#{key}/#{value}"
          response = @conn.get(url)
          return (JSON.parse(response.body)) if response.status == 200
        end

        def find(model_name,filters = {})
          filters = {} if filters.nil?
          url = "#{model_name}?"
          filters.each { |key,value|
            url.concat("#{key}=\"#{value}\"")
          }
          response = @conn.get(url)
          JSON.parse(response.body)
        end

      end

    end
  end
end
