module SoupCMS
  module Core
    module Controller

      class PageController < SoupCMS::Common::Controller::BaseController

        def soupcms_api
          @soupcms_api ||= SoupCMS::Core::Api::Service.new(context.application, context.drafts?)
        end

        def execute
          context.params['model_name'] = 'pages'
          page_hash = soupcms_api.find_by_key(context.model_name, 'slug', context.slug)
          model = SoupCMS::Core::Model::Document.new(page_hash)
          SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
        end

      end

    end
  end
end
