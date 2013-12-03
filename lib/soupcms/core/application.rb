module SoupCMS
  module Core
    class Application

      def initialize(app_name)
        @app_name = app_name
        @data = SoupCMS::Core::Data::Service.new(app_name)
      end

      def find(slug)
        slugs = slug.split('/').reject(&:empty?)
        @data.find_by_key(slugs[0], 'slug', slugs[1]) if slugs.size == 2
      end

    end
  end
end