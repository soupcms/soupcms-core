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

        def soupcms_api_host_url
          @soupcms_api_host_url ||= SoupCMSApp.config.soupcms_api_host_url
        end

      end

    end
  end
end
