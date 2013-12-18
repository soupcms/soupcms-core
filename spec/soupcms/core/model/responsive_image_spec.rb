require 'spec_helper'

describe SoupCMS::Core::Model::ResponsiveImage do

  before(:each) do
    SoupCMS::Core::Model::ResponsiveImage.register 'cloudinary', SoupCMS::Core::Model::CloudinaryResponsiveImage
    SoupCMS::Core::Model::ResponsiveImage.register 'cdnconnect', SoupCMS::Core::Model::CdnConnectResponsiveImage
  end

  context 'cloudinary' do

    image_hash = <<-json
    {
      "source": "cloudinary",
      "base_url": "http://t.co/image/",
      "desktop": "img1.jpg",
      "mobile": "img1m.jpg"
    }
    json

    context 'non retina' do
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(JSON.parse(image_hash), 'w_1660,h_200,c_crop', 'w_960,h_200,c_crop', 'w_480,h_200,c_crop') }
      it { expect(image.desktop_url).to eq('http://t.co/image/w_1660,h_200,c_crop/img1.jpg') }
      it { expect(image.tablet_url).to eq('http://t.co/image/w_960,h_200,c_crop/img1.jpg') }
      it { expect(image.mobile_url).to eq('http://t.co/image/w_480,h_200,c_crop/img1m.jpg') }
    end

    context 'retina' do
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(JSON.parse(image_hash), 'w_1660,h_200,c_crop', 'w_960,h_200,c_crop', 'w_480,h_200,c_crop') }
      it { expect(image.desktop_retina_url).to eq('http://t.co/image/w_3320,h_400,c_crop/img1.jpg') }
      it { expect(image.tablet_retina_url).to eq('http://t.co/image/w_1920,h_400,c_crop/img1.jpg') }
      it { expect(image.mobile_retina_url).to eq('http://t.co/image/w_960,h_400,c_crop/img1m.jpg') }
    end

    context 'default crop as fill' do
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(JSON.parse(image_hash), 'w_1660,h_200', 'w_960,h_200', 'w_480,h_200') }
      it { expect(image.desktop_retina_url).to eq('http://t.co/image/w_3320,h_400,c_fill/img1.jpg') }
      it { expect(image.tablet_retina_url).to eq('http://t.co/image/w_1920,h_400,c_fill/img1.jpg') }
      it { expect(image.mobile_retina_url).to eq('http://t.co/image/w_960,h_400,c_fill/img1m.jpg') }
    end

  end

  context 'cdnconnect' do

    image_hash = <<-json
    {
      "source": "cdnconnect",
      "base_url": "http://t.co/image/",
      "desktop": "img1.jpg",
      "mobile": "img1m.jpg"
    }
    json

    context 'non retina' do
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(JSON.parse(image_hash), 'w_1660,h_200', 'w_960,h_200', 'w_480,h_200') }
      it { expect(image.desktop_url).to eq('http://t.co/image/img1.jpg?w=1660&h=200&mode=max') }
      it { expect(image.tablet_url).to eq('http://t.co/image/img1.jpg?w=960&h=200&mode=max') }
      it { expect(image.mobile_url).to eq('http://t.co/image/img1m.jpg?w=480&h=200&mode=max') }
    end

    context 'retina' do
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(JSON.parse(image_hash), 'w_1660,h_200', 'w_960,h_200', 'w_480,h_200') }
      it { expect(image.desktop_retina_url).to eq('http://t.co/image/img1.jpg?w=1660&h=200&x=2&mode=max') }
      it { expect(image.tablet_retina_url).to eq('http://t.co/image/img1.jpg?w=960&h=200&x=2&mode=max') }
      it { expect(image.mobile_retina_url).to eq('http://t.co/image/img1m.jpg?w=480&h=200&x=2&mode=max') }
    end

  end


end