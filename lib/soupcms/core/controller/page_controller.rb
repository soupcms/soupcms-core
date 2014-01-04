module SoupCMS
  module Core
    module Controller

      class PageController

        def execute(context)
          context.params['model_name'] = 'pages'
          page_hash = context.soupcms_api.find_by_key(context.model_name, 'slug', context.slug)
          model = SoupCMS::Core::Model::Document.new(page_hash)
          SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
        end

      end

    end
  end
end
