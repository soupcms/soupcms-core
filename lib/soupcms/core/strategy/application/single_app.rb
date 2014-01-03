module SoupCMS
  module Core
    module Strategy
      module Application

        class SingleApp < ApplicationStrategy

          def self.configure
            yield self
          end

          def self.app_name=(app_name)
            @@app_name = app_name
          end

          def self.display_name=(display_name)
            @@display_name = display_name
          end

          def self.soupcms_api_url=(soupcms_api_url)
            @@soupcms_api_url = soupcms_api_url
          end

          def app_name
            @@app_name
          end

          def display_name
            @@display_name
          end

          def soupcms_api_url
            @@soupcms_api_url
          end

          def path
            request.path[1..-1]
          end

        end

      end
    end
  end
end

