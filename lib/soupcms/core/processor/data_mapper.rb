
module SoupCMS
  module Core
    module Processor


      class DataMapper

        def initialize(recipe_hash, page_module)
          @recipe_hash = recipe_hash
          @page_module = page_module
        end

        def execute
          result = {}
          @recipe_hash['map'].each do |key,value|
            result[key] = @page_module.instance_eval("#{value}")
          end
          result
        end
      end

    end
   end
end