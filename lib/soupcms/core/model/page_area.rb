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

        def soupcms_api
          @soupcms_api ||= SoupCMS::Core::Api::Service.new(context.application, context.drafts?)
        end

        def context
          page.context
        end

        def modules
          @modules ||= @area_hash['modules'].collect { |module_hash| create_page_module(module_hash) }
        end

        def create_page_module(module_hash)
          if module_hash.kind_of?(String)
            module_hash = soupcms_api.find_by_key('modules','doc_id',module_hash).to_hash
          end
          PageModule.new(module_hash, self)
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

        def wrapper?
          name != 'meta'
        end
      end


    end
  end
end