module SoupCMS
  module Core
    module Model

      class Application


        def initialize(name, display_name = nil)
          @name = name
          @display_name = display_name
        end

        attr_reader :name, :display_name

        def soupcms_api(drafts)
          SoupCMS::Core::Api::Service.new(self,drafts)
        end

        def soupcms_api_host_url
          @soupcms_api_host_url ||= SoupCMSCore.config.soupcms_api_host_url
        end

        def self.get(name)
          @@apps ||= {}
          if @@apps[name].nil?
            @@apps[name] = Application.new(name, "soupCMS #{name}")
          end
          @@apps[name]
        end

      end

    end
  end
end
