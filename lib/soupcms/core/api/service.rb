require 'json'

module SoupCMS
  module Core
    module Api

      class Service < Base

        def find_by_key(model, key, value, fields = [])
          url = "#{model}/#{key}/#{value}"
          params = {}
          params[:fields] = fields unless fields.nil? || fields.empty?
          response = execute_url(url, params)
          parse_response(response) unless response.nil?
        end

        def find(model_name, filters = {}, fields = [], limit = nil)
          url = model_name
          params = {}
          params.merge! filters
          filter_keys = filters.keys
          filter_keys.delete(:tags) || filter_keys.delete('tags')
          params[:filters] = filter_keys unless filter_keys.empty?
          params[:fields] = fields unless fields.nil? || fields.empty?
          params[:limit] = limit if limit
          response = execute_url(url, params)
          return parse_response(response) unless response.nil?
          []
        end

        def fetch_by_url(url)
          response = execute_url(url)
          parse_response(response) unless response.nil?
        end

        protected

        def execute_url(url, params = {} )
          params[:include] = 'drafts' if drafts
          url = File.join(application.soupcms_api_host_url, '/api', application.name, url)
          SoupCMS::Core::Utils::HttpClient.new.get(url, params)
        end


        def parse_response(response)
          docs = JSON.parse(response)
          return docs.collect{ |doc| SoupCMS::Core::Model::Document.new(doc) } if docs.kind_of?(Array)
          return SoupCMS::Core::Model::Document.new(docs)
        end

      end

    end
  end
end
