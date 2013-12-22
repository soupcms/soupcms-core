require 'sprockets'
require 'sprockets-helpers'

module SoupCMS
  module Core

      module ConfigDefaults
        TEMPLATE_DIR = File.join(File.dirname(__FILE__),'ui')
        RECIPES = {
            'inline' => SoupCMS::Core::Recipe::Inline,
            'soupcms-api' => SoupCMS::Core::Recipe::SoupCMSApi
        }
        RESPONSIVE_IMAGE_PROVIDERS = {
            'cloudinary' => SoupCMS::Core::Model::CloudinaryResponsiveImage,
            'cdnconnect' => SoupCMS::Core::Model::CdnConnectResponsiveImage
        }
      end

      class Config

        def self.configs
          @@config ||= SoupCMS::Core::Config.new
        end

        def initialize
          @soupcms_api_host_url = 'http://localhost:9292/'
          @responsive_image = SoupCMS::Core::Model::ResponsiveImage
          @recipes = ConfigDefaults::RECIPES

          @sprockets = Sprockets::Environment.new
          Sprockets::Helpers.configure do |config|
            config.environment = sprockets
            config.prefix = '/assets'
            config.public_path = nil
          end
          Slim::Engine.set_default_options pretty: true, disable_escape: true

          @template_manager = SoupCMS::Core::Template::TemplateManager.new
          @template_manager.register(SoupCMS::Core::Template::TemplateFileStore.new(ConfigDefaults::TEMPLATE_DIR))
          @sprockets.append_path ConfigDefaults::TEMPLATE_DIR

          ConfigDefaults::RESPONSIVE_IMAGE_PROVIDERS.each { |source,provider|
            SoupCMS::Core::Model::ResponsiveImage.register source,provider
          }
        end

        attr_accessor :soupcms_api_host_url, :responsive_image
        attr_reader :sprockets, :recipes, :template_manager

        def register_recipe(type, recipe)
          @recipes[type] = recipe
        end

        def clear_recipes
          @recipes = []
        end

      end


  end
end
