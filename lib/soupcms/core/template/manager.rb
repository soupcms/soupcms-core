require 'tilt'

module SoupCMS
  module Core
    module Template

      class Manager

        DEFAULT_TEMPLATE_DIR = File.join(File.dirname(__FILE__), '../../../../ui')

        def self.stores
          @@stores ||= [
              SoupCMS::Core::Template::SoupCMSApiStore,
              SoupCMS::Core::Template::FileStore.new(DEFAULT_TEMPLATE_DIR)
          ]
        end

        def self.template_cache
          @@cache ||= {}
        end

        def self.append_store(template)
          stores.push template
        end

        def self.prepend_store(template)
          stores.unshift template
        end

        def self.clear
          @@stores = []
          @@cache = {}
        end




        def find_module(context, template_name, type)
          find_template(context, template_name, type, 'module')
        end

        def find_layout(context, template_name, type)
          find_template(context, template_name, type, 'layout')
        end

        def find(context, template_path)
          template = find_template(context, template_path.split('.').first, template_path.split('.').last)
          raise "Could not find template #{template_path}" if template.nil?
          template
        end

        def inline(context, template_content, type)
          Tilt.new(type) { template_content }
        end

        private
        def find_template(context, template_name, type, kind = nil)
          key = "#{kind}/#{template_name}.#{type}"
          cache = self.class.template_cache
          unless cache[key]
            self.class.stores.each do |store|
              store = store.kind_of?(Class) ? store.new : store
              value = store.find_template(context, template_name, type, kind)
              unless value.nil?
                template = Tilt.new(key) { value }
                return template if context.environment != 'production'
                cache[key] = template
                break
              end
            end
          end
          cache[key]
        end

      end


    end
  end
end
