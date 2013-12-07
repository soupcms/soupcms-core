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

      end

    end
  end
end

