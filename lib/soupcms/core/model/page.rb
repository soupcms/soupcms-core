module SoupCMS
  module Core
    module Model

      class Page

        def initialize(page_hash, context = {}, model = {})
          @page_hash = page_hash
          @context = context
          @model = model
        end

        attr_accessor :context, :model

        def render
          areas.each { |name,area|
            area.html = area.modules.collect { |m| m.render }.join('\n')
          }
          areas.collect { |name,area| area.html }.join('\n')
        end

        def areas
          @areas ||= Hash[
              @page_hash['areas'].collect do |area_hash|
                area = PageArea.new(area_hash, @context, @model)
                [ area.name, area ]
              end
          ]
        end

      end


      class PageArea

        def initialize(area_hash,context,model)
          @name = area_hash['name']
          @area_hash = area_hash
          @context = context
          @model = model
        end

        attr_accessor :html
        attr_reader :name

        def modules
          @modules ||= @area_hash['modules'].collect { |module_hash| PageModule.new(module_hash,@context,@model) }
        end


      end

    end


    class PageModule

      def initialize(module_hash,context,model)
        @module_hash = module_hash
        @model = model
        @context = context
      end

      def render
        <<-response
      <html>
        <head> <title>Page title</title>  </head>
        <body> Yes this works..... </body>
      </html>
        response
      end


    end


  end
end