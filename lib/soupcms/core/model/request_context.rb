module SoupCMS
  module Core
    module Model

      class RequestContext

        def initialize(application, params = {})
          @application = application
          @params = params
        end

        attr_accessor :model_name, :slug
        attr_reader :application, :params

        def user_params
          @params.to_hash.delete('route_info')
        end

        def soupcms_api
          @soupcms_api ||= application.soupcms_api(drafts?)
        end

        def drafts?
          params['include'] == 'drafts'
        end

      end

    end
  end
end

