module SoupCMS
  module Core
    module Model


      class PageArea

        def initialize(area_hash, page)
          @name = area_hash['name']
          @area_hash = area_hash
          @page = page
        end

        attr_accessor :html
        attr_reader :name, :page

        def modules
          @modules ||= @area_hash['modules'].collect { |module_hash| PageModule.new(module_hash, self) }
        end

        def render_area
          modules.collect { |page_module| page_module.render_module }.join("\n")
        end

        def javascripts
          modules.collect { |page_module| page_module.javascript }.flatten
        end

        def stylesheets
          modules.collect { |page_module| page_module.stylesheet }.flatten
        end

      end


    end
  end
end