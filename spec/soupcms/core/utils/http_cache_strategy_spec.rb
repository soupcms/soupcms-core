require 'spec_helper'

describe SoupCMS::Core::Utils::HttpCacheStrategy do

  let (:application) { SoupCMS::Core::Model::Application.new('soupcms-test','soupcms-test','http://localhost:9292/api/soupcms-test') }

  it 'should it should set cache header to default 5 min' do
    context = SoupCMS::Core::Model::RequestContext.new(application, { 'model_name' => 'posts' })
    headers = SoupCMS::Core::Utils::HttpCacheStrategy.new.headers(context)
    expect(headers.size).to eq(2)
    expect(headers['Cache-Control']).to eq('public, max-age=300')
    expect(headers['Expires']).not_to be_nil
  end

  it 'should not set cache headers when requested for drafts' do
    context = SoupCMS::Core::Model::RequestContext.new(application, { 'model_name' => 'posts', 'include' => 'drafts' })
    headers = SoupCMS::Core::Utils::HttpCacheStrategy.new.headers(context)
    expect(headers.size).to eq(0)
  end

  it 'should respect max age set' do
    context = SoupCMS::Core::Model::RequestContext.new(application, { 'model_name' => 'posts' })
    SoupCMS::Core::Utils::HttpCacheStrategy.default_max_age = 5000
    headers = SoupCMS::Core::Utils::HttpCacheStrategy.new.headers(context)
    expect(headers.size).to eq(2)
    expect(headers['Cache-Control']).to eq('public, max-age=5000')
    expect(headers['Expires']).not_to be_nil
    SoupCMS::Core::Utils::HttpCacheStrategy.default_max_age = SoupCMS::Core::Utils::HttpCacheStrategy::DEFAULT_MAX_AGE
  end

end