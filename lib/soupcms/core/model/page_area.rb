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
        attr_reader :name

        def modules
          @modules ||= @area_hash['modules'].collect { |module_hash| PageModule.new(module_hash, @page) }
        end

        def render
          modules.collect { |page_module| page_module.render }.join('\n')
        end

      end


    end
  end
end