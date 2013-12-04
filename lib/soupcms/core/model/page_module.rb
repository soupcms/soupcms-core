module SoupCMS
  module Core
    module Model

      class PageModule

        def initialize(module_hash, context, model)
          @module_hash = module_hash
          @model = model
          @context = context
        end

        def render
          <<-response
      <html>
        <head> <title>Page title</title>  </head>
        <body> Yes this works..... </body>
      </html>
          response
        end


      end


    end
  end
end