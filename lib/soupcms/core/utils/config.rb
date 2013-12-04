module SoupCMS
  module Core

    module Utils

      module ConfigDefaults
        RECIPES = {

        }

      end

      class Config

        def initialize
          @soupcms_api_host_url = 'http://localhost:9292'
          @recipes = ConfigDefaults::RECIPES
        end

        attr_accessor :soupcms_api_host_url

        def register_recipes(recipes)
          @recipes.merge! recipes
        end


      end

    end
  end
end
