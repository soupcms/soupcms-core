module SoupCMS
  module Core
    module Model

      class AppInfo

        def initialize(name)
          @name = name
        end

        attr_reader :name

        def data
          SoupCMS::Core::Data::Service.new(self)
        end

      end

    end
  end
end
