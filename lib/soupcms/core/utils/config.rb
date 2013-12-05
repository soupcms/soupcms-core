module SoupCMS
  module Core

    module Utils

      module ConfigDefaults
        TEMPLATE_DIR = File.dirname(__FILE__) + "/../template"
        RECIPES = {
        }
      end

      class Config

        def initialize
          @soupcms_api_host_url = 'http://localhost:9292'
          @recipes = ConfigDefaults::RECIPES
          @template_dir = ConfigDefaults::TEMPLATE_DIR
        end

        attr_accessor :soupcms_api_host_url, :template_dir

        def register_recipes(recipes)
          @recipes.merge! recipes
        end

        def recipes
          @recipes
        end


      end

    end
  end
end
