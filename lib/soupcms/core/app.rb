require 'grape'

class SoupCMSApp < ::Grape::API
  content_type :txt, 'text/html'

  get '/soupcms-api-test/posts/my-first-blog' do
    <<-response
      <html>
        <head> <title>My first blog post</title>  </head>
        <body> Yes this works..... </body>
      </html>
    response
  end

end