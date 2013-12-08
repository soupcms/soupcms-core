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
          url = build_url(model_name, filters)
          response = connection.get(url)
          return JSON.parse(response.body) if response.status == 200
          []
        end

        def build_url(model_name, filters)
          return model_name if filters.nil? || filters.empty?
          url = "#{model_name}?"
          filter_index = 0
          filters.each { |key, value|
            url.concat('&') if filter_index >= 1
            if value.kind_of?(String)
              url.concat("#{key}=\"#{value}\"")
            elsif value.kind_of?(Integer)
              url.concat("#{key}=#{value}")
            elsif value.kind_of?(Array)
              index = 0
              value.each do |val|
                url.concat('&') if index >= 1
                url.concat("#{key}[]=\"#{val}\"") if val.kind_of?(String)
                url.concat("#{key}[]=#{val}") if val.kind_of?(Integer)
                index += 1
              end
            end
            url.concat("&filters[]=#{key}") unless key == "tags" || key == :tags
            filter_index += 1
          }
          url
        end

      end

    end
  end
end
