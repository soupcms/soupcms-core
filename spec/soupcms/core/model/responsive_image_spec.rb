require 'spec_helper'

describe SoupCMS::Core::Model::ResponsiveImage do

  let (:context) { SoupCMS::Common::Model::RequestContext.new(application) }

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
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_crop', tablet: 'w_960,h_200,c_crop', mobile: 'w_480,h_200,c_crop'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }
      it { expect(image.desktop_url).to eq('http://t.co/image/w_1660,h_200,c_crop/img1.jpg') }
      it { expect(image.tablet_url).to eq('http://t.co/image/w_960,h_200,c_crop/img1.jpg') }
      it { expect(image.mobile_url).to eq('http://t.co/image/w_480,h_200,c_crop/img1m.jpg') }
    end

    context 'retina' do
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_crop', tablet: 'w_960,h_200,c_crop', mobile: 'w_480,h_200,c_crop'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }
      it { expect(image.desktop_retina_url).to eq('http://t.co/image/w_3320,h_400,c_crop/img1.jpg') }
      it { expect(image.tablet_retina_url).to eq('http://t.co/image/w_1920,h_400,c_crop/img1.jpg') }
      it { expect(image.mobile_retina_url).to eq('http://t.co/image/w_960,h_400,c_crop/img1m.jpg') }
    end

    context 'default crop as fit' do
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200', tablet: 'w_960,h_200', mobile: 'w_480,h_200'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }
      it { expect(image.desktop_retina_url).to eq('http://t.co/image/w_3320,h_400,c_fit/img1.jpg') }
      it { expect(image.tablet_retina_url).to eq('http://t.co/image/w_1920,h_400,c_fit/img1.jpg') }
      it { expect(image.mobile_retina_url).to eq('http://t.co/image/w_960,h_400,c_fit/img1m.jpg') }
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
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200', tablet: 'w_960,h_200', mobile: 'w_480,h_200'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }
      it { expect(image.desktop_url).to eq('http://t.co/image/img1.jpg?w=1660&h=200&mode=max') }
      it { expect(image.tablet_url).to eq('http://t.co/image/img1.jpg?w=960&h=200&mode=max') }
      it { expect(image.mobile_url).to eq('http://t.co/image/img1m.jpg?w=480&h=200&mode=max') }
    end

    context 'retina' do
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200', tablet: 'w_960,h_200', mobile: 'w_480,h_200'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }
      it { expect(image.desktop_retina_url).to eq('http://t.co/image/img1.jpg?w=1660&h=200&x=2&mode=max') }
      it { expect(image.tablet_retina_url).to eq('http://t.co/image/img1.jpg?w=960&h=200&x=2&mode=max') }
      it { expect(image.mobile_retina_url).to eq('http://t.co/image/img1m.jpg?w=480&h=200&x=2&mode=max') }
    end

    context 'crop mapping from cloudinary' do
      it 'should map pad to default' do
        responsive_image_hash = {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_pad'}
        image = SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash)
        expect(image.desktop_url).to eq('http://t.co/image/img1.jpg?w=1660&h=200&mode=default')
      end

      it 'should map fill to crop' do
        responsive_image_hash = {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_fill'}
        image = SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash)
        expect(image.desktop_url).to eq('http://t.co/image/img1.jpg?w=1660&h=200&mode=crop')
      end

      it 'should map scale to stretch' do
        responsive_image_hash = {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_scale'}
        image = SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash)
        expect(image.desktop_url).to eq('http://t.co/image/img1.jpg?w=1660&h=200&mode=stretch')
      end


    end

  end


end