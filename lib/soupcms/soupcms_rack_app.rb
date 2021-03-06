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
    headers = {'Location' => redirect_to}
    headers.merge! SoupCMSCore.config.http_caching_strategy.new.cache_headers
    redirects[url] = [redirect_code, headers, []]
  end

  attr_accessor :router

  def call(env)
    status = 200
    headers = {'Content-Type' => 'text/html'}

    request = Rack::Request.new(env)
    return redirects[request.url] if redirects[request.url]

    strategy = SoupCMSCore.config.application_strategy.new(request)
    if strategy.app_name.nil? || strategy.path.nil?
      headers.merge! SoupCMSCore.config.http_caching_strategy.new.cache_headers
      return [404, headers, [strategy.not_found_message]]
    end

    context = SoupCMS::Common::Model::RequestContext.new(strategy.application, request.params)

    page = router.resolve(strategy.path, context.params).new(context).execute

    if page.nil? || page['error']
      headers.merge! SoupCMSCore.config.http_caching_strategy.new.cache_headers
      return [404, headers, [strategy.not_found_message]]
    end

    headers.merge! SoupCMSCore.config.http_caching_strategy.new.headers(context.params)
    body = page.render_page
    [status, headers, [body]]

  end


end