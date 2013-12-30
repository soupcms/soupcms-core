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
          model_name = @recipe_hash['model'] ? eval_value(@recipe_hash['model']) : context.model_name
          return soupcms_api.fetch_by_url(eval_value(@recipe_hash['url'])) if @recipe_hash['url']
          soupcms_api.find(model_name, eval_hash(@recipe_hash['match']), @recipe_hash['fields'], @recipe_hash['limit'])
        end

        def eval_hash(document)
          return {} if document.nil?
          document.each do |key, value|
            case value.class
              when Array
                document[key] = value.collect { |item| item.kind_of?(Hash) ? eval_hash(item) : eval_value(item) }
              when Hash
                document[key] = eval_hash(value)
              else
                document[key] = eval_value(value)
            end
          end
        end

        def eval_value(value)
          return value unless value.kind_of?(String)
          @page_module.instance_eval "\"#{value}\""
        end

      end

    end
  end
end
