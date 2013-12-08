require 'spec_helper'

describe SoupCMS::Core::Data::Service do

  let (:application) { SoupCMS::Core::Model::Application.new('soupcms-test') }
  let (:service) { SoupCMS::Core::Data::Service.new(application)  }

  context 'find module by key' do
    it 'should return parsed JSON object for 200 response' do
      stub_request(:get, /pages\/slug\/home/).to_return({body: read_file('pages/home') } )
      doc = service.find_by_key('pages','slug','home')
      expect( doc['title'] ).to eq('Page title')
    end

    it 'should return parsed JSON object for 404 response' do
      stub_request(:get, /pages\/slug\/home/).to_return( status: 404 )
      doc = service.find_by_key('pages','slug','home')
      expect( doc ).to be_nil
    end
  end

  context 'find with filters' do
    it 'should return parsed JSON objects for 200 response' do
      stub_request(:get, /posts\?tags="popular"$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
      docs = service.find('posts',{ tags: 'popular' })
      expect(docs.size).to eq(2)
      expect(docs[0]['title']).to eq('My first blog post')
      expect(docs[1]['title']).to eq('My second blog post')
    end

    it 'should return empty array for 404 response' do
      stub_request(:get, /posts\?tags="popular"$/).to_return(status: 404)
      docs = service.find('posts',{ tags: 'popular' })
      expect(docs.size).to eq(0)
    end

    it 'should send appropriate request without quotes for integer value' do
      stub_request(:get, /posts\?filters%5B0%5D=rank&rank=100$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
      docs = service.find('posts',{ rank: 100 })
      expect(docs.size).to eq(2)
    end

    it 'should send appropriate request for array value' do
      stub_request(:get, /posts\?tags%5B0%5D=%22popular%22&tags%5B1%5D=%22liked%22$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
      docs = service.find('posts',{ tags: %w(popular liked) })
      expect(docs.size).to eq(2)
    end

    it 'should handle multiple filter parameters' do
      stub_request(:get, /posts\?filters%5B0%5D=rank&rank=100&tags=%22popular%22$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
      docs = service.find('posts',{ rank: 100, tags: 'popular' })
      expect(docs.size).to eq(2)
    end

    it 'should handle no filters specified' do
      stub_request(:get, /posts$/).to_return({body: read_files('posts/first-post', 'posts/second-post')})
      docs = service.find('posts',nil)
      expect(docs.size).to eq(2)
    end
  end
end