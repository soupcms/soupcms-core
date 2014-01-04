require 'spec_helper'

describe SoupCMS::Core::Recipe::SoupCMSApi do

  let(:context) { SoupCMS::Core::Model::RequestContext.new(application, {'model_name' => 'posts'}) }
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
        "fields": ["title"],
        "return": "posts"
    }
      json
      SoupCMS::Core::Recipe::SoupCMSApi.new(JSON.parse(recipe_json), page_module)
    end
    let(:posts) do
      stub_request(:get, /posts\?fields%5B0%5D=title&tags=popular$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
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

  context 'tag cloud' do
    let(:recipe) do
      recipe_json = <<-json
      {
          "type": "soupcms-api",
          "url": "posts/tag-cloud",
          "return": "tag-cloud"
      }
      json
      SoupCMS::Core::Recipe::SoupCMSApi.new(JSON.parse(recipe_json), page_module)
    end
    let(:tagcloud) do
      stub_request(:get, /posts\/tag\-cloud$/).to_return({body: read_file('posts/tag-cloud')})
      recipe.execute
    end

    it { expect(tagcloud).to be_kind_of(Array) }
    it { expect(tagcloud.size).to eq(5) }
    it { expect(tagcloud[0]['label']).to eq('Design Principles') }
  end

  context 'eval values in recipe' do

    let(:recipe) do
      recipe_json = <<-json
    {
        "type": "soupcms-api",
        "model": "posts",
        "match": {
            "tags": "#{page.context.application.name}-append"
        },
        "return": "posts"
    }
      json
      SoupCMS::Core::Recipe::SoupCMSApi.new(JSON.parse(recipe_json), page_module)
    end
    let(:posts) do
      stub_request(:get, /posts\?tags=soupcms-test-append$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
      recipe.execute
    end

    it { expect(posts).to be_kind_of(Array) }
    it { expect(posts.size).to eq(2) }
  end


end