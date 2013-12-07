module SoupCMS
  module Core
    module Model

      class Application


        def initialize(name)
          @name = name
        end

        attr_reader :name

        def soup_cms_api
          @soup_cms_api ||= SoupCMS::Core::Data::Service.new(self)
        end

        def soup_cms_api_host_url
          @soup_cms_api_host_url ||= SoupCMSApp.config.soup_cms_api_host_url
        end

        def self.get(name)
          @@apps ||= {}
          if @@apps[name].nil?
            @@apps[name] = Application.new(name)
          end
          @@apps[name]
        end

      end

    end
  end
end
