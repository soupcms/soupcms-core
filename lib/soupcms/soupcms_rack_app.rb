class SoupCMSRackApp

  def call(env)
    status = 200
    headers = {'Content-Type' => 'text/html'}

    request = Rack::Request.new(env)
    app_name, slug = parse_path(request)
    return [404, headers, ["Page '#{slug}' not found in application '#{app_name}'"]] if app_name.nil? || slug.nil?

    application = SoupCMS::Core::Model::Application.get(app_name)
    context = SoupCMS::Core::Model::RequestContext.new(application, request.params)

    service = SoupCMS::Core::PageRouteService.new(context)
    page = service.find(slug)

    return [404, headers, ["Page '#{slug}' not found in application '#{app_name}'"]] if page.nil?

    headers.merge! SoupCMSCore.config.http_caching_strategy.new.headers(context) if context.environment == 'production'
    body = page.render_page
    [status, headers, [body]]

  end

  def parse_path(request)
    url_parser = request.path.match(/\/[\w\.\-]*\//)
    if url_parser
      app_name = url_parser[0].gsub('/', '')
      slug = url_parser.post_match
      return app_name, slug
    end
  end

end