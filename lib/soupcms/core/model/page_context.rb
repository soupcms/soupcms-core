module SoupCMS
  module Core
    module Model

      class PageContext

        def initialize(params = {})
          @params = params
        end

        attr_accessor :params


      end

    end
  end
end

