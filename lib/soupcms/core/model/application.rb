module SoupCMS
  module Core
    module Model

      class Application

        def initialize(name)
          @name = name
        end

        attr_reader :name

        def data
          @data ||= SoupCMS::Core::Data::Service.new(self)
        end

      end

    end
  end
end
