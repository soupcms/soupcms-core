module SoupCMS
  module Core
    class PageRouteService

      def initialize(context)
        @context = context
      end

      attr_reader :context

      def soupcms_api
        context.soupcms_api
      end

      def route_dsl
        <<-dsl
          # TODO: implement following DSL for route mapping, this should be used for reverse url building (link resolver)

          route 'blog/:type/:slug', PostsSlugRoute('posts', type, slug)      # define your own url patters

          route ':model/:slug', ModelSlugRoute(model,slug)                # generic model url pattern
          route '*', PageRoute                                            # default pages url pattern
        dsl
      end

      def find(slug)
        slugs = slug.split('/').reject(&:empty?)
        if(slugs.size == 1)
          context.model_name = 'pages'
          context.slug = slugs[0]
          page_hash = soupcms_api.find_by_key(context.model_name, 'slug', context.slug)
          model = SoupCMS::Core::Model::Document.new(page_hash)
          page = SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
        else(slugs.size == 2)
          context.model_name = slugs[0]
          context.slug = slugs[1]
          model_hash = soupcms_api.find_by_key(context.model_name, 'slug', context.slug)
          if model_hash
            model = SoupCMS::Core::Model::Document.new(model_hash)
            page_hash = soupcms_api.find_by_key('pages', 'meta.model', context.model_name)
            page = SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
          end
        end
        page
      end

    end
  end
end