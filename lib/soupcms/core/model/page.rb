require 'sprockets'
require 'sprockets-helpers'

module SoupCMS
  module Core
    module Model

      class Page
        include Sprockets::Helpers

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

        def javascripts
          areas.collect { |name, area| area.javascripts }.flatten.uniq
        end

        def stylesheets
          areas.collect { |name, area| area.stylesheets }.flatten.uniq
        end

        def include_stylesheets
          Tilt.new("#{SoupCMSApp.config.template_dir}/system/include_stylesheets.slim",{disable_escape: true}).render(self)
        end

        def include_javascripts
          Tilt.new("#{SoupCMSApp.config.template_dir}/system/include_javascripts.slim",{disable_escape: true}).render(self)
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