require 'spec_helper'

describe SoupCMS::Core::Model::Document do

  let(:document) {SoupCMS::Core::Model::Document.new({ 'title' => 'Title', 'publish_datetime' => 1386914582 })}

  context 'publish_datetime' do
    it{ expect(document.publish_datetime).to eq(Time.at(1386914582))}
  end

end