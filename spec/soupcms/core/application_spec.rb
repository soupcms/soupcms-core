require 'spec_helper'

describe SoupCMS::Core::Application do

  let (:application) { SoupCMS::Core::Application.new('soupcms-test') }

  it 'should find a page for slug' do
    stub_request(:get,/posts\/slug\/my-first-blog-post$/).to_return( { body: {page: 'page'}.to_json } )
    page = application.find('/posts/my-first-blog-post')
    expect(page).to be_kind_of(SoupCMS::Core::Model::Page)
  end

  it 'should not find a page for invalid slug' do
    stub_request(:get,/posts\/slug\/invalid-blog-post$/).to_return( { status: 404 } )
    page = application.find('/posts/invalid-blog-post')
    expect(page).to be_nil
  end

  it 'should not find a page for invalid url' do
    page = application.find('/invalid')
    expect(page).to be_nil
  end
end