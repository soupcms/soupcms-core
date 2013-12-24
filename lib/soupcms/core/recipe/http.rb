module SoupCMS
  module Core
    module Recipe

      class Http

        def initialize(recipe_hash, page_module)
          @recipe_hash = recipe_hash
          @page_module = page_module
        end

        def execute
          @page_module.context
          url = @page_module.instance_eval("\"#{@recipe_hash['url']}\"")
          response = SoupCMS::Core::Utils::HttpClient.new.get(url, eval_hash(@recipe_hash['params']))
          JSON.parse(response.body) if response.status == 200
        end

        private
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
