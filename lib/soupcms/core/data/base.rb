module SoupCMS
  module Core
    module Data

      class Base

        def initialize(application , drafts = false)
          @application = application
          @drafts = drafts
        end

        attr_reader :application

        def drafts?
          @drafts
        end

      end

    end
  end
end
