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
          areas.each { |name, area|
            area.html = area.modules.collect { |m| m.render }.join('\n')
          }
          areas.collect { |name, area| area.html }.join('\n')
        end

        def areas
          @areas ||= Hash[
              @page_hash['areas'].collect do |area_hash|
                area = PageArea.new(area_hash, @context, @model)
                [area.name, area]
              end
          ]
        end

      end


    end
  end
end