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

        def find_module(context, template_name, type)
          find_template(context, template_name, type, 'module')
        end

        def find_layout(context, template_name, type)
          find_template(context, template_name, type, 'layout')
        end

        def find(context, template_path)
          find_template(context, template_path.split('.').first, template_path.split('.').last)
        end

        def inline(context, template_content, type)
          Tilt.new(type) { template_content }
        end

        private
        def find_template(context, template_name, type, kind = nil)
          key = "#{kind}/#{template_name}.#{type}"
          unless @cache[key]
            @stores.each do |store|
              store = store.new if store.kind_of?(Class)
              value = store.find(context, template_name, type, kind)
              unless value.nil?
                template = Tilt.new(key) { value }
                return template if context.environment != 'production'
                @cache[key] = template
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
