require 'grape'

class SoupCMSApp < ::Grape::API
  content_type :txt, 'text/html'

  def self.config
    @@config ||= SoupCMS::Core::Utils::Config.new
  end

  group ':app_name' do
    get '*slug' do
      params_hash = params.to_hash
      params_hash.delete('route_info') # remove unwanted context information
      context = SoupCMS::Core::Model::PageContext.new(params)
      app = SoupCMS::Core::Application.new(params['app_name'])
      page = app.find(params['slug'], context)
      #error!("Page #{params['slug']} not found in application #{params['app_name']}", 404) if page.nil?
      page.render
    end

  end

end