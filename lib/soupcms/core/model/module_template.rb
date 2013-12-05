require 'tilt'

module SoupCMS
  module Core
    module Model


      class ModuleTemplate

        def initialize(template_hash,page)
          @template_hash = template_hash
          @page = page
        end

        def render
          Tilt.new(template_file).render(@page)
        end

        private
        def full_name
          @template_hash['name']
        end

        def name
          full_name.split('/').last
        end

        def template_file
          "#{SoupCMSApp.config.template_dir}/module/#{full_name}/#{name}.#{@template_hash['type']}"
        end


      end

    end
  end
end
