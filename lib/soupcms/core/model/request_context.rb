module SoupCMS
  module Core
    module Model

      class RequestContext

        def initialize(application, params = {})
          @application = application
          @params = params
        end

        attr_accessor :model_name
        attr_reader :application, :params

        def user_params
          @params.to_hash.delete('route_info')
        end

        def soup_cms_api
          @soup_cms_api ||= application.soup_cms_api(drafts?)
        end

        def drafts?
          params['include'] == 'drafts'
        end

      end

    end
  end
end

