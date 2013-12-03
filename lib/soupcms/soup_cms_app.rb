require 'grape'

class SoupCMSApp < ::Grape::API
  content_type :txt, 'text/html'

  group ':app_name' do
    get '*slug' do
      app = SoupCMS::Core::Application.new(params['app_name'])
      page = app.find(params['slug'])
      #error!("Page #{params['slug']} not found in application #{params['app_name']}", 404) if page.nil?
      page.render
    end

  end

end