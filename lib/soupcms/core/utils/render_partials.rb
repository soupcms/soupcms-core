module SoupCMS
  module Core
    module Utils


      module RenderPartials

        def render(template_path_from_template_root, locals = {})
          Tilt.new("#{SoupCMS::Core::Config.configs.template_dir}/#{template_path_from_template_root}").render(self, locals)
        end

      end


    end
  end
end

