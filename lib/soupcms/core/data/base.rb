module SoupCMS
  module Core
    module Data

      class Base

        def initialize(application)
          @application = application
        end

        attr_reader :application

      end

    end
  end
end
