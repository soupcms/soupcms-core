module SoupCMS
  module Core
    module Api

      class Base

        def initialize(application , drafts = false)
          @application = application
          @drafts = drafts
        end

        attr_reader :application, :drafts

      end

    end
  end
end
