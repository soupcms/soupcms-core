require 'tilt'

module SoupCMS
  module Core
    module Template


      class TemplateManager

        def initialize
          @stores = []
          @cache = {}
        end

        def register(*templates)
          @stores.concat templates
        end

        def clear
          @stores = []
          @cache = {}
        end

        def find_module(template_name, type)
          find_template(template_name, type, 'module')
        end

        def find_layout(template_name, type)
          find_template(template_name, type, 'layout')
        end

        def find(template_path)
          find_template(template_path.split('.').first, template_path.split('.').last)
        end

        def inline(template_content, type)
          Tilt.new(type) { template_content }
        end

        private
        def find_template(template_name, type, kind = nil)
          key = "#{kind}/#{template_name}/#{type}"
          unless @cache[key]
            @stores.each do |store|
              value = store.find(template_name, type, kind)
              unless value.nil?
                @cache[key] = Tilt.new(type) { value }
                break
              end
            end
          end
          @cache[key]
        end

      end


    end
  end
end
