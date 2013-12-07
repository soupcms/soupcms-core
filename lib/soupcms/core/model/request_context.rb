module SoupCMS
  module Core
    module Model

      class RequestContext

        def initialize(app_info, params = {})
          @app_info = app_info
          @params = params
        end

        attr_accessor :model_name
        attr_reader :app_info, :params

        def user_params
          @params.to_hash.delete('route_info')
        end

      end

    end
  end
end

