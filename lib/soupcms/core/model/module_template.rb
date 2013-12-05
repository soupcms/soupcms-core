require 'tilt'

module SoupCMS
  module Core
    module Model


      class ModuleTemplate

        def initialize(template_hash,page)
          @template_hash = template_hash
          @page = page
        end

        def template_file
          "#{SoupCMSApp.config.template_dir}/module/#{@template_hash['name']}/#{@template_hash['name']}.#{@template_hash['type']}"
        end

        def render
          Tilt.new(template_file).render(@page)
        end

      end

    end
  end
end
