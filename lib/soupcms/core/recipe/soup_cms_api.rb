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
          soup_cms_api = context.application.soup_cms_api
          soup_cms_api.find(context.model_name,@recipe_hash['match'])
        end

      end

    end
  end
end
