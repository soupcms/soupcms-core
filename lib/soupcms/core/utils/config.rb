require 'sprockets'
require 'slim'

module SoupCMS
  module Core
    module Utils

      class Config

        def initialize
          Slim::Engine.set_options pretty: true, disable_escape: true
        end

        def application_strategy
          @application_strategy ||= SoupCMS::Common::Strategy::Application::UrlBased
        end

        def application_strategy=(strategy)
          @application_strategy = strategy
        end

        def responsive_image
          @responsive_image ||= SoupCMS::Core::Model::ResponsiveImage
        end

        def responsive_image=(responsive_image)
          @responsive_image = responsive_image
        end

        def http_caching_strategy
          @http_caching_strategy ||= SoupCMS::Common::Util::HttpCacheStrategy
        end

        def http_caching_strategy=(caching_strategy)
          @http_caching_strategy = caching_strategy
        end

        def sprockets
          @sprockets ||= Sprockets::Environment.new
        end

        def sprockets=(sprockets_env)
          @sprockets = sprockets_env
        end

        def template_manager
          @template_manager ||= SoupCMS::Core::Template::Manager
        end

        def template_manager=(manager)
          @template_manager = manager
        end

        def recipes
          @recipes ||= {
              'inline' => SoupCMS::Core::Recipe::Inline,
              'http' => SoupCMS::Core::Recipe::Http,
              'soupcms-api' => SoupCMS::Core::Recipe::SoupCMSApi,
              'post-processor' => SoupCMS::Core::Recipe::PostProcessor
          }
        end

        def register_recipe(type, recipe)
          @recipes[type] = recipe
        end

        def clear_recipes
          @recipes = []
        end

      end


    end
  end
end
