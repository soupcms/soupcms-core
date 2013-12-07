module SoupCMS
  module Core
    module Model

      class PageContext

        def initialize(app_info, params = {})
          @app_info = app_info
          @params = params
        end

        attr_accessor :model_name
        attr_reader :app_info, :params

      end

    end
  end
end

