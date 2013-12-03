module SoupCMS
  module Core
    module Model

      class Page

        def initialize(slug)
          @slug = slug
        end

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