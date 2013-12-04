module SoupCMS
  module Core
    module Model


      class PageArea

        def initialize(area_hash, context, model)
          @name = area_hash['name']
          @area_hash = area_hash
          @context = context
          @model = model
        end

        attr_accessor :html
        attr_reader :name

        def modules
          @modules ||= @area_hash['modules'].collect { |module_hash| PageModule.new(module_hash, @context, @model) }
        end


      end


    end
  end
end