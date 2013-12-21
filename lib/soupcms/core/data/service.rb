require 'json'

module SoupCMS
  module Core
    module Data

      class Service < Base

        def connection
          @http ||= Net::HTTP.new(application.soup_cms_api_host_url)
        end

        def find_by_key(model, key, value)
          url = "#{model}/#{key}/#{value}"
          response = execute(url)
          parse_response(response) if response.code == '200'
        end

        def find(model_name, filters = {})
          url = SoupCMS::Core::Utils::UrlBuilder.build(model_name, filters)
          response = execute(url)
          return parse_response(response) if response.code == '200'
          []
        end

        def fetch_by_url(url)
          response = execute(url)
          parse_response(response) if response.code == '200'
        end

        private
        def execute(url)
          if drafts?
            url.include?('?') ? url.concat('&') : url.concat('?')
            url = url.concat('include=drafts')
          end
          url = File.join('/api', application.name, url)
          connection.request(Net::HTTP::Get.new(url))
        end


        def parse_response(response)
          docs = JSON.parse(response.body)
          return docs.collect{ |doc| SoupCMS::Core::Model::Document.new(doc) } if docs.kind_of?(Array)
          return SoupCMS::Core::Model::Document.new(docs)
        end

      end

    end
  end
end
