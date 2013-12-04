module SoupCMS
  module Core
    class Application

      def initialize(app_name)
        @app_name = app_name
        @data = SoupCMS::Core::Data::Service.new(app_name)
      end

      def find(slug, context = {})
        slugs = slug.split('/').reject(&:empty?)
        if slugs.size == 1
          page_hash = @data.find_by_key('pages', 'slug', slugs[0])
          page = SoupCMS::Core::Model::Page.new(page_hash, context) if page_hash
        else slugs.size == 2
          model_hash = @data.find_by_key(slugs[0], 'slug', slugs[1])
          if model_hash
            model = SoupCMS::Core::Model::Document.new(model_hash)
            page_hash = @data.find_by_key('pages', 'model', slugs[0])
            page = SoupCMS::Core::Model::Page.new(page_hash, context, model) if page_hash
          end
        end
        page
      end

    end
  end
end