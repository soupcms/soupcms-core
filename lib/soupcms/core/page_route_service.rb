module SoupCMS
  module Core
    class PageRouteService

      def initialize(context)
        @context = context
        @data = context.app_info.data
      end

      attr_reader :context, :data

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
          model_name = 'pages'
          slug = slugs[0]
          context.model_name = model_name
          page_hash = @data.find_by_key(model_name, 'slug', slug)
          model = SoupCMS::Core::Model::Document.new(page_hash)
          page = SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
        else(slugs.size == 2)
          model_name = slugs[0]
          slug = slugs[1]
          context.model_name = model_name
          model_hash = @data.find_by_key(model_name, 'slug', slug)
          if model_hash
            model = SoupCMS::Core::Model::Document.new(model_hash)
            page_hash = @data.find_by_key('pages', 'model', model_name)
            page = SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
          end
        end
        page
      end

    end
  end
end