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
            SoupCMSCore.config.template_manager.new.inline(@page_module.context, inline_template, type).render(@page_module)
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
          return js if SoupCMSCore.config.sprockets[js]
        end

        def stylesheet
          return if inline_template
          css = "module/#{full_name}/#{name}.css"
          return css if SoupCMSCore.config.sprockets[css]
        end

        private

        def name
          full_name.split('/').last
        end

        def template
          SoupCMSCore.config.template_manager.new.find_module(@page_module.context,full_name,type)
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
