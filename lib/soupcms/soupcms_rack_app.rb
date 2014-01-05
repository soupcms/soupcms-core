class SoupCMSRackApp

  def initialize
    @router = SoupCMS::Common::Router.new
    @router.add ':model_name/:slug', SoupCMS::Core::Controller::ModelController
    @router.default SoupCMS::Core::Controller::PageController
  end

  def redirects
    @redirects ||= {}
  end

  def set_redirect(url, redirect_to, redirect_code = 301)
    redirects[url] = [redirect_code, {'Location' => redirect_to}, []]
  end

  attr_accessor :router

  def call(env)
    status = 200
    headers = {'Content-Type' => 'text/html'}

    request = Rack::Request.new(env)
    return redirects[request.url] if redirects[request.url]

    strategy = SoupCMSCore.config.application_strategy.new(request)
    return [404, headers, [strategy.not_found_message]] if strategy.app_name.nil? || strategy.path.nil?

    context = SoupCMS::Common::Model::RequestContext.new(strategy.application, request.params)

    page = router.resolve(strategy.path, context.params).new(context).execute

    return [404, headers, [strategy.not_found_message]] if page.nil?

    headers.merge! SoupCMSCore.config.http_caching_strategy.new.headers(context.params)
    body = page.render_page
    [status, headers, [body]]

  end


end