module SoupCMS
  module Core
    module Strategy
      module Application

        class ApplicationStrategy

          def initialize(request)
            @request = request
          end

          attr_reader :request

          def app_name
            raise 'Implement method app_name'
          end

          def display_name
            app_name
          end

          def path
            raise 'Implement method path'
          end

          def soupcms_api_url
            raise 'Implement method soupcms_api_url'
          end

          def not_found_message
            "Page '#{path}' not found in application '#{app_name}'"
          end

          def application
            @@apps ||= {}
            if @@apps[app_name].nil?
              @@apps[app_name] = SoupCMS::Core::Model::Application.new(app_name, display_name, soupcms_api_url)
            end
            @@apps[app_name]
          end

          def self.apps=(apps = {})
            @@apps = apps
          end

        end

      end
    end
  end
end

