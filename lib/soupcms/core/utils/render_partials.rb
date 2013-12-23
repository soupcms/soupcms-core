module SoupCMS
  module Core
    module Utils


      module RenderPartials

        def render(template_path, locals = {})
          SoupCMS::Core::Config.configs.template_manager.find(context,template_path).render(self, locals)
        end

      end


    end
  end
end

