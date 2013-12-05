module SoupCMS
  module Core
    module Model

      class Page

        def initialize(page_hash, context = {}, model = {})
          @page_hash = page_hash
          @context = context
          @model = model
          @data = {}
        end

        attr_accessor :context, :model
        attr_reader :data

        def render
          areas.each { |name, area| area.html = area.render }
          areas.collect { |name, area| area.html }.join('\n')  # to be replace with layout
        end

        def areas
          @areas ||= Hash[
              @page_hash['areas'].collect do |area_hash|
                area = PageArea.new(area_hash, self)
                [area.name, area]
              end
          ]
        end

      end


    end
  end
end