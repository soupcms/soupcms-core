class SoupCMSRackApp

  def initialize
    @router = SoupCMS::Common::Router.new
    @router.add ':model_name/:slug', SoupCMS::Core::Controller::ModelController
    @router.default SoupCMS::Core::Controller::PageController
  end

  attr_accessor :router

  def call(env)
    status = 200
    headers = {'Content-Type' => 'text/html'}

    request = Rack::Request.new(env)
    strategy = SoupCMSCore.config.application_strategy.new(request)
    return [404, headers, [strategy.not_found_message]] if strategy.app_name.nil? || strategy.path.nil?

    context = SoupCMS::Core::Model::RequestContext.new(strategy.application, request.params)

    page = router.resolve(strategy.path, context.params).new.execute(context)

    return [404, headers, [strategy.not_found_message]] if page.nil?

    headers.merge! SoupCMSCore.config.http_caching_strategy.new.headers(context.params)
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