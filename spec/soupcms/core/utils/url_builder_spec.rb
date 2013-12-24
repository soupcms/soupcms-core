require 'spec_helper'

describe SoupCMS::Core::Utils::UrlBuilder do

  it 'should should add fields to the get request url' do
    url = '/soupcms-test/posts/slug/first-post'
    url = SoupCMS::Core::Utils::UrlBuilder.drafts(url,true)
    expect(url).to eq('/soupcms-test/posts/slug/first-post?include=drafts')
  end
end