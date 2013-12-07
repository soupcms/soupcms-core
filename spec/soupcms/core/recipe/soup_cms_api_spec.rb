require 'spec_helper'

describe SoupCMS::Core::Recipe::SoupCMSApi do

  let(:application) { SoupCMS::Core::Model::Application.new('soupcms-test') }
  let(:context) do
    context = SoupCMS::Core::Model::RequestContext.new(application)
    context.model_name = 'posts'
    context
  end
  let(:page) { SoupCMS::Core::Model::Page.new({}, context) }
  let(:page_area) { SoupCMS::Core::Model::PageArea.new({}, page) }
  let(:page_module) { SoupCMS::Core::Model::PageModule.new({}, page_area) }


  context 'popular posts' do
    let(:recipe) do
      recipe_json = <<-json
    {
        "type": "soupcms-api",
        "model": "posts",
        "match": {
            "tags": "popular"
        },
        "return": "posts"
    }
      json
      SoupCMS::Core::Recipe::SoupCMSApi.new(JSON.parse(recipe_json), page_module)
    end
    let(:posts) do
      stub_request(:get, /posts\?tags="popular"$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
      recipe.execute
    end

    it { expect(posts).to be_kind_of(Array) }
    it { expect(posts.size).to eq(2) }
    it { expect(posts[0]['title']).to eq('My first blog post') }
    it { expect(posts[1]['title']).to eq('My second blog post') }
  end

  context 'posts' do
    let(:recipe) do
      recipe_json = <<-json
    {
        "type": "soupcms-api",
        "model": "posts",
        "return": "posts"
    }
      json
      SoupCMS::Core::Recipe::SoupCMSApi.new(JSON.parse(recipe_json), page_module)
    end
    let(:posts) do
      stub_request(:get, /posts$/).to_return({body: read_files('posts/first-post')})
      recipe.execute
    end

    it { expect(posts).to be_kind_of(Array) }
    it { expect(posts.size).to eq(1) }
    it { expect(posts[0]['title']).to eq('My first blog post') }
  end


end