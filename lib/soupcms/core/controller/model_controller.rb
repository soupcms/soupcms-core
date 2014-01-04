module SoupCMS
  module Core
    module Controller

      class ModelController < SoupCMS::Common::Controller::BaseController

        def soupcms_api
          @soupcms_api ||= SoupCMS::Core::Api::Service.new(context.application, context.drafts?)
        end

        def execute
          model_hash = soupcms_api.find_by_key(context.model_name, 'slug', context.slug)
          if model_hash
            model = SoupCMS::Core::Model::Document.new(model_hash)
            page_hash = soupcms_api.find_by_key('pages', 'meta.model', context.model_name)
            return SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
          end
        end

      end

    end
  end
end
