require 'sprockets'
require 'sprockets-helpers'

module SoupCMS
  module Core
    module Model

      class Page
        include Sprockets::Helpers
        include SoupCMS::Core::Utils::RenderPartials

        def initialize(page_hash, context, model = {})
          @page_hash = page_hash
          @context = context
          @model = model
        end

        attr_accessor :context, :model

        def render_page
          areas.each { |name, area| area.html = area.render_area }
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
          @layout ||= PageLayout.new(@page_hash['layout'],self)
        end

        def javascripts
          [layout.javascript].concat(areas.collect { |name, area| area.javascripts }.flatten.uniq).compact
        end

        def stylesheets
          [layout.stylesheet].concat(areas.collect { |name, area| area.stylesheets }.flatten.uniq).compact
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