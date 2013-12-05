module SoupCMS
  module Core
    module Model

      class PageLayout

        def initialize(layout_hash,page)
          @layout_hash = layout_hash
          @page = page
        end

        def render
          Tilt.new(layout_file).render(@page)
        end

        private

        def full_name
          @layout_hash['name']
        end

        def type
          @layout_hash['type']
        end

        def layout_file
          "#{SoupCMSApp.config.template_dir}/layout/#{full_name}.#{type}"
        end

      end


    end
  end
end