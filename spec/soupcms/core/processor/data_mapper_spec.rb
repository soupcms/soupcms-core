require 'spec_helper'

describe SoupCMS::Core::Processor::DataMapper do

  describe 'map' do

    it 'should create different map structure from given map' do

      projects = [{'title' => 'soupCMS', 'url' => 'http://www.soupcms.com'}]

      page_module = SoupCMS::Core::Model::PageModule.new({}, nil)
      page_module.data['author'] = {'projects' => projects, 'name' => 'Sunit Parkeh', 'twitter' => 'sunitparekh'}
      recipe_hash = {
          'map' => {'projects' => "data['author']['projects']", 'username' => "data['author']['twitter']"},
          'return' => 'articles'
      }
      result = SoupCMS::Core::Processor::DataMapper.new(recipe_hash, page_module).execute
      expect(result).to eq({'projects' => projects, 'username' => 'sunitparekh'})

    end

  end


end