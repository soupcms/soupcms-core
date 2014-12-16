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

    context 'crop mapping' do
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


  context 'cloudinary without base url' do
    image_hash = <<-json
        {
          "source": "cloudinary",
          "desktop": "img1.jpg",
          "mobile": "img1m.jpg"
        }
    json

    context 'non retina' do
      before(:each) do
        ENV['CLOUDINARY_BASE_URL'] = 'http://base.url/base'
      end
      after(:each) do
        ENV.delete('CLOUDINARY_BASE_URL')
      end
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200', tablet: 'w_960,h_200', mobile: 'w_480,h_200'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }
      it { expect(image.desktop_url).to eq('http://base.url/base/w_1660,h_200,c_fit/img1.jpg') }
      it { expect(image.tablet_url).to eq('http://base.url/base/w_960,h_200,c_fit/img1.jpg') }
      it { expect(image.mobile_url).to eq('http://base.url/base/w_480,h_200,c_fit/img1m.jpg') }
    end

  end

  context 'cdnconnect without base url' do
    image_hash = <<-json
        {
          "source": "cdnconnect",
          "desktop": "img1.jpg",
          "mobile": "img1m.jpg"
        }
    json

    context 'non retina' do
      before(:each) do
        ENV['CDNCONNECT_BASE_URL'] = 'http://base.url/base'
      end
      after(:each) do
        ENV.delete('CDNCONNECT_BASE_URL')
      end
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200', tablet: 'w_960,h_200', mobile: 'w_480,h_200'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }
      it { expect(image.desktop_url).to eq('http://base.url/base/img1.jpg?w=1660&h=200&mode=max') }
      it { expect(image.tablet_url).to eq('http://base.url/base/img1.jpg?w=960&h=200&mode=max') }
      it { expect(image.mobile_url).to eq('http://base.url/base/img1m.jpg?w=480&h=200&mode=max') }
    end

  end

  context 'build open graph image url' do

    context 'jpg image with absolute url' do
      image_hash = <<-json
        {
          "source": "cloudinary",
          "base_url": "http://t.co/image/",
          "desktop": "img1.jpg"
        }
      json
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_crop'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }

      it { expect(image.open_graph_url).to eq('http://t.co/image/w_1660,h_200,c_crop/img1.jpg') }
    end

    context 'base url without protocol' do
      image_hash = <<-json
        {
          "source": "cloudinary",
          "base_url": "//t.co/image/",
          "desktop": "img1.jpg"
        }
      json
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_crop'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }

      it { expect(image.open_graph_url).to eq('http://t.co/image/w_1660,h_200,c_crop/img1.jpg') }
    end

    context 'svg image and base url without protocol' do
      image_hash = <<-json
        {
          "source": "cloudinary",
          "base_url": "//t.co/image/",
          "desktop": "img1.svg"
        }
      json
      let(:responsive_image_hash) { {image: JSON.parse(image_hash), desktop: 'w_1660,h_200,c_crop'} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }

      it { expect(image.open_graph_url).to eq('http://t.co/image/w_1660,h_200,c_crop/img1.png') }
    end

    context 'svg image and base url without protocol and no sizes' do
      image_hash = <<-json
        {
          "source": "cloudinary",
          "base_url": "//t.co/image/",
          "desktop": "img1.svg"
        }
      json
      let(:responsive_image_hash) { {image: JSON.parse(image_hash)} }
      let(:image) { SoupCMS::Core::Model::ResponsiveImage.build(context, responsive_image_hash) }

      it { expect(image.open_graph_url).to eq('http://t.co/image/img1.png') }
    end


  end

end