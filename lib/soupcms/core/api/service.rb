require 'json'

module SoupCMS
  module Core
    module Api

      class Service < Base

        def find_by_key(model, key, value, fields = [])
          url = "#{model}/#{key}/#{value}"
          url = SoupCMS::Core::Utils::UrlBuilder.drafts(url, drafts)
          params = {}
          params[:fields] = fields unless fields.nil? || fields.empty?
          response = execute_url(url, params)
          parse_response(response) if response.status == 200
        end

        def find(model_name, filters = {}, fields = [])
          url = SoupCMS::Core::Utils::UrlBuilder.build(model_name, filters)
          url = SoupCMS::Core::Utils::UrlBuilder.drafts(url, drafts)
          params = {}
          params[:fields] = fields unless fields.nil? || fields.empty?
          response = execute_url(url, params)
          return parse_response(response) if response.status == 200
          []
        end

        def fetch_by_url(url)
          url = SoupCMS::Core::Utils::UrlBuilder.drafts(url, drafts)
          response = execute_url(url)
          parse_response(response) if response.status == 200
        end

        protected

        def execute_url(url, params = {} )
          url = File.join(application.soupcms_api_host_url, '/api', application.name, url)
          SoupCMS::Core::Utils::HttpClient.new.get(url, params)
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
