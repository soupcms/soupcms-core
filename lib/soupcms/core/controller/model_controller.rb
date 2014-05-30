module SoupCMS
  module Core
    module Controller

      class ModelController < SoupCMS::Common::Controller::BaseController

        def soupcms_api
          @soupcms_api ||= SoupCMS::Core::Api::Service.new(context.application, context.drafts?)
        end

        def execute
          filters = context.params.select { |k,v| context.params['_slug_keys'].include?(k) && k != 'model_name' }
          model_hash = soupcms_api.find_by_keys(context.model_name, filters)
          if model_hash
            model = SoupCMS::Core::Model::Document.new(model_hash)
            page_hash = soupcms_api.find_by_keys('pages', {'meta.model' => context.model_name, 'meta.slug' => context.slug })
            if page_hash.nil? || page_hash['error']
              page_hash = soupcms_api.find_by_key('pages', 'meta.model', context.model_name)
            end
            return SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
          end
        end

      end

    end
  end
end
