require 'grape'

class SoupCMSApp < ::Grape::API
  content_type :txt, 'text/html'

  group ':app_name' do

    params do
      optional :include, type: String, default: 'published'
    end
    get '*slug' do
      application = SoupCMS::Core::Model::Application.get(params['app_name'])
      context = SoupCMS::Core::Model::RequestContext.new(application, params)

      app = SoupCMS::Core::PageRouteService.new(context)
      page = app.find(params['slug'])
      error!("Page #{params['slug']} not found in application #{params['app_name']}", 404) if page.nil?
      page.render_page
    end

  end

end