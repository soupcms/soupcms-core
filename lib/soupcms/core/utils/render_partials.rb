module SoupCMS
  module Core
    module Utils


      module RenderPartials

        def render(template_path, locals = {})
          SoupCMSCore.config.template_manager.new.find(context,template_path).render(self, locals)
        end

      end


    end
  end
end

