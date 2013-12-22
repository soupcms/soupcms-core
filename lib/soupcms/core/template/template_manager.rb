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

        def find(kind, template_name, type)
          key = "#{kind}/#{template_name}/#{type}"
          unless @cache[key]
            @stores.each do |store|
              value = store.find(kind, template_name, type)
              unless value.nil?
                @cache[key] = Tilt.new(type) { value }
                break
              end
            end
          end
          @cache[key]
        end

        def find_partial(template_path)
          key = "partial/#{template_path}"
          type = template_path.split('.').last
          unless @cache[key]
            @stores.each do |store|
              value = store.find_partial(template_path)
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
