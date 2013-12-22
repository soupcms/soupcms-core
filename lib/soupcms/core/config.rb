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
          @template_dir = ConfigDefaults::TEMPLATE_DIR
          @sprockets = Sprockets::Environment.new
          @sprockets.append_path @template_dir
          Sprockets::Helpers.configure do |config|
            config.environment = sprockets
            config.prefix = '/assets'
            config.public_path = nil
          end
          Slim::Engine.set_default_options pretty: true, disable_escape: true

          ConfigDefaults::RESPONSIVE_IMAGE_PROVIDERS.each { |source,provider|
            SoupCMS::Core::Model::ResponsiveImage.register source,provider
          }
        end

        attr_accessor :soupcms_api_host_url, :responsive_image
        attr_reader :sprockets, :template_dir, :recipes

        def template_dir=(template_dir)
          @template_dir = template_dir
          @sprockets.append_path template_dir
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
