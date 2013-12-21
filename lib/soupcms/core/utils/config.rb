require 'sprockets'
require 'sprockets-helpers'

module SoupCMS
  module Core

    module Utils

      module ConfigDefaults
        TEMPLATE_DIR = File.dirname(__FILE__) + '/../template'
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

        def initialize
          @soup_cms_api_host_url = 'http://localhost:9292/'
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

        attr_accessor :soup_cms_api_host_url
        attr_reader :sprockets, :template_dir

        def template_dir=(template_dir)
          @template_dir = template_dir
          @sprockets.append_path template_dir
        end

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
