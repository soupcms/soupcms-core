require 'spec_helper'

describe SoupCMS::Core::Recipe::Http do

  let(:context) { SoupCMS::Common::Model::RequestContext.new(application, {'model_name' => 'posts', 'slug' => 'my-first-post'}) }
  let(:page) { SoupCMS::Core::Model::Page.new({}, context) }
  let(:page_area) { SoupCMS::Core::Model::PageArea.new({}, page) }
  let(:page_module) { SoupCMS::Core::Model::PageModule.new({}, page_area) }


  it 'should return data' do
    http_recipe = <<-json
    {
        "type": "http",
        "url" : "http://localhost:9292/api/\#{context.model_name}/slug/\#{context.slug}",
        "return": "page-header"
    }
    json
    response_json = <<-json
    { "title": "my title"}
    json
    recipe = SoupCMS::Core::Recipe::Http.new(JSON.parse(http_recipe),page_module)
    stub_request(:get, 'http://localhost:9292/api/posts/slug/my-first-post').to_return({body: response_json })
    expect(recipe.execute).to eq({ 'title' => 'my title'})
  end

  it 'should return data' do
    http_recipe = <<-json
    {
        "type": "http",
        "url" : "http://localhost:9292/api/\#{context.model_name}",
        "params" : {
          "slug" : "\#{context.slug}"
        },
        "return": "page-header"
    }
    json
    response_json = <<-json
    { "title": "my title"}
    json
    recipe = SoupCMS::Core::Recipe::Http.new(JSON.parse(http_recipe),page_module)
    stub_request(:get, 'http://localhost:9292/api/posts?slug=my-first-post').to_return({body: response_json })
    expect(recipe.execute).to eq({ 'title' => 'my title'})
  end

end