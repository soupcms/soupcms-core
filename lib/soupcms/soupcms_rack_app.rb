class SoupCMSRackApp

  def call(env)
    status = 200
    headers = {'Content-Type' => 'text/html'}
    request = Rack::Request.new(env)
    m = request.path.match(/\/[\w\.\-]*\//)

    return [404, headers, ["Invalid url request #{request.path}"]] if m.nil?

    app_name = m[0].gsub('/', '')
    slug = m.post_match


    application = SoupCMS::Core::Model::Application.get(app_name)
    context = SoupCMS::Core::Model::RequestContext.new(application, request.params)

    app = SoupCMS::Core::PageRouteService.new(context)
    page = app.find(slug)

    return [404, headers, ["Page '#{slug}' not found in application '#{app_name}'"]] if page.nil?

    headers.merge! SoupCMS::Core::Config.configs.http_caching_strategy.new.headers(context) if context.environment == 'production'
    body = page.render_page
    [status, headers, [body]]

  end

end