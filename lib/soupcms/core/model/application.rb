module SoupCMS
  module Core
    module Model

      class Application


        def initialize(name)
          @name = name
        end

        attr_reader :name

        def soup_cms_api(drafts)
          SoupCMS::Core::Data::Service.new(self,drafts)
        end

        def soupcms_api_host_url
          @soupcms_api_host_url ||= SoupCMS::Core::Config.configs.soupcms_api_host_url
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
