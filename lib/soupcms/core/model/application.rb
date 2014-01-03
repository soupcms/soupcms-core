module SoupCMS
  module Core
    module Model

      class Application


        def initialize(name, display_name, soupcms_api_url)
          @name = name
          @display_name = (display_name || name)
          @soupcms_api_url = soupcms_api_url
        end

        attr_reader :name, :display_name, :soupcms_api_url

        def soupcms_api(drafts)
          SoupCMS::Core::Api::Service.new(self,drafts)
        end

      end

    end
  end
end
