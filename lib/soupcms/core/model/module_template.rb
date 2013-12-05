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
          if full_name
            Tilt.new(template_file,{disable_escape: true}).render(@page_module)
          else
            Tilt.new(type) { template }.render(@page_module)
          end
        end

        def full_name
          @template_hash['name']
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

        def template
          @template_hash['template']
        end


      end

    end
  end
end
