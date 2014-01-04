module SoupCMS
  module Core
    module Model

      class RequestContext

        def initialize(application, params = {})
          @application = application
          @params = params
        end

        attr_reader :application, :params

        def model_name
          params['model_name']
        end

        def slug
          params['slug']
        end

        def user_params
          @params.to_hash.delete('route_info')
        end

        def soupcms_api
          @soupcms_api ||= SoupCMS::Core::Api::Service.new(application, drafts?)
        end

        def drafts?
          params['include'] == 'drafts'
        end

        def environment
          ENV['RACK_ENV'] || 'test'
        end

      end

    end
  end
end

