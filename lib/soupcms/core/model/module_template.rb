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
            Tilt.new(type) { inline_template }.render(@page_module)
          else
            Tilt.new(template_file,{disable_escape: true}).render(@page_module)
          end
        end

        def full_name
          @template_hash['name']
        end

        def javascript
          return if inline_template
          "module/#{full_name}/#{name}.js"
        end

        def stylesheet
          return if inline_template
          "module/#{full_name}/#{name}.css"
        end

        private

        def name
          full_name.split('/').last
        end

        def template_file
          "#{SoupCMSApp.config.template_dir}/module/#{full_name}/#{name}.#{type}"
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
