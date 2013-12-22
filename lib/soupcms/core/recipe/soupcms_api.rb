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
          soupcms_api = context.soupcms_api
          model_name = @recipe_hash['model'] ? @recipe_hash['model'] : context.model_name
          return soupcms_api.fetch_by_url(@recipe_hash['url']) if @recipe_hash['url']
          soupcms_api.find(model_name, @recipe_hash['match'])
        end

      end

    end
  end
end
