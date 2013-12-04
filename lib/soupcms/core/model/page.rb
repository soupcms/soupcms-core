module SoupCMS
  module Core
    module Model

      class Page

        def initialize(page_hash, context = {}, model = {})
          @page_hash = page_hash
          @context = context
          @model = model
        end

        attr_accessor :context, :model

        def render
          <<-response
      <html>
        <head> <title>My first blog post</title>  </head>
        <body> Yes this works..... </body>
      </html>
          response
        end



      end



    end
  end
end