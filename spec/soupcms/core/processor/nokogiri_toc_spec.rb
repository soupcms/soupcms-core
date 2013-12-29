require 'spec_helper'

describe SoupCMS::Core::Processor::NokogiriTOC do

  it 'example 1' do
    html = <<-html
      <h2 id="header-1-1">Header 1 1</h2>
      <p>Here's a paragraph</p>

      <h3 id="header-1-1-1">Header 1 1 1</h3>
      <p>Here's a paragraph</p>

      <h3 id="header-1-1-2">Header 1 1 2</h3>
      <p>Here's a paragraph</p>

      <h2 id="header-1-2">Header 1 2</h2>
      <p>Here's a paragraph</p>

      <h3 id="header-1-2-1">Header 1 2 1</h3>
      <p>Here's a paragraph</p>
    html
    expected = [
      {
        'label' => 'Header 1 1', 'href' => '#header-1-1',
        'children' => [
          { 'label' => 'Header 1 1 1', 'href' => '#header-1-1-1', 'children' => [] },
          { 'label' => 'Header 1 1 2', 'href' => '#header-1-1-2', 'children' => [] }
        ]
      },
      {
        'label' => 'Header 1 2', 'href' => '#header-1-2',
        'children' => [
          { 'label' => 'Header 1 2 1', 'href' => '#header-1-2-1', 'children' => [] }
        ]
      }
    ]
    toc = SoupCMS::Core::Processor::NokogiriTOC.new(html).build_toc
    expect(toc).to eq(expected)
  end

  it 'example 2 header with spaces' do
    html = <<-html
      <h1 id="header-1">


     Header 1

      </h1>
      <p>Here's a paragraph</p>

      <h2 id="header-1-1">Header 1 1</h2>
      <p>Here's a paragraph</p>

      <h3 id="header-1-1-1">Header 1 1 1</h3>
      <p>Here's a paragraph</p>

      <h3 id="header-1-1-2">Header 1 1 2</h3>
      <p>Here's a paragraph</p>

      <h2 id="header-1-2">Header 1 2</h2>
      <p>Here's a paragraph</p>

      <h3 id="header-1-2-1">Header 1 2 1</h3>
      <p>Here's a paragraph</p>
    html
    expected = [
      {
          'label' => 'Header 1', 'href' => '#header-1',
          'children' => [
              {
                  'label' => 'Header 1 1', 'href' => '#header-1-1',
                  'children' => [
                      { 'label' => 'Header 1 1 1', 'href' => '#header-1-1-1', 'children' => [] },
                      { 'label' => 'Header 1 1 2', 'href' => '#header-1-1-2', 'children' => [] }
                  ]
              },
              {
                  'label' => 'Header 1 2', 'href' => '#header-1-2',
                  'children' => [
                      { 'label' => 'Header 1 2 1', 'href' => '#header-1-2-1', 'children' => [] }
                  ]
              }
          ]
      }
    ]
    toc = SoupCMS::Core::Processor::NokogiriTOC.new(html).build_toc
    expect(toc).to eq(expected)
  end


end