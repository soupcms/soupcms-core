require 'grape'

class SoupCMSApp < ::Grape::API
  content_type :txt, 'text/html'

  group ':app_name' do
    get '*slug' do
      params_hash = params.to_h
      params_hash.delete('route_info')
      context = SoupCMS::Core::Model::PageContext.new(params)
      app = SoupCMS::Core::Application.new(params['app_name'])
      page = app.find(params['slug'], context)
      #error!("Page #{params['slug']} not found in application #{params['app_name']}", 404) if page.nil?
      page.render
    end

  end

end