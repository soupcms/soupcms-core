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
          return js if SoupCMSCore.config.sprockets[js]
        end

        def stylesheet
          css = "layout/#{full_name}/#{name}.css"
          return css if SoupCMSCore.config.sprockets[css]
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
          SoupCMSCore.config.template_manager.find_layout(@page.context,full_name,type)
        end

      end


    end
  end
end