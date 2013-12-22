module SoupCMS
  module Core
    module Model

      class PageLayout

        def initialize(layout_hash,page)
          @layout_hash = layout_hash
          @page = page
        end

        def render
          layout.render(@page)
        end

        def javascript
          js = "layout/#{full_name}/#{name}.js"
          return js if SoupCMS::Core::Config.configs.sprockets[js]
        end

        def stylesheet
          css = "layout/#{full_name}/#{name}.css"
          return css if SoupCMS::Core::Config.configs.sprockets[css]
        end

        private

        def full_name
          @layout_hash['name']
        end

        def name
          full_name.split('/').last
        end

        def type
          @layout_hash['type']
        end

        def layout
          SoupCMS::Core::Config.configs.template_manager.find('layout',full_name,type)
        end

      end


    end
  end
end