require 'tilt'

module SoupCMS
  module Core
    module Model


      class ModuleTemplate

        def initialize(template_hash,page_module)
          @template_hash = template_hash
          @page_module = page_module
        end

        def render
          if inline_template
            SoupCMS::Core::Config.configs.template_manager.inline(inline_template, type).render(@page_module)
          else
            template.render(@page_module)
          end
        end

        def full_name
          @template_hash['name']
        end

        def javascript
          return if inline_template
          js = "module/#{full_name}/#{name}.js"
          return js if SoupCMS::Core::Config.configs.sprockets[js]
        end

        def stylesheet
          return if inline_template
          css = "module/#{full_name}/#{name}.css"
          return css if SoupCMS::Core::Config.configs.sprockets[css]
        end

        private

        def name
          full_name.split('/').last
        end

        def template
          SoupCMS::Core::Config.configs.template_manager.find('module',full_name,type)
        end

        def type
          @template_hash['type']
        end

        def inline_template
          template = @template_hash['template']
          if template.kind_of? Array
            template.join("\n")
          else
            template
          end
        end


      end

    end
  end
end
