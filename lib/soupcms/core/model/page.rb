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
          areas.each { |name, area| area.html = area.render }
          layout.render
        end

        def areas
          return {} if @page_hash['areas'].nil?
          @areas ||= Hash[
              @page_hash['areas'].collect do |area_hash|
                area = PageArea.new(area_hash, self)
                [area.name, area]
              end
          ]
        end

        def layout
          PageLayout.new(@page_hash['layout'],self)
        end

        def [](key)
          @page_hash[key]
        end

        def page
          self
        end
      end


    end
  end
end