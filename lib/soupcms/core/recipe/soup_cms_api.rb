module SoupCMS
  module Core
    module Recipe

      class SoupCMSApi

        def initialize(recipe_hash, page_module)
          @recipe_hash = recipe_hash
          @page_module = page_module
        end

        def execute
          context = @page_module.page.context
          service = context.app_info.data
          service.find(context.model_name,@recipe_hash['match'])
        end

      end

    end
  end
end
