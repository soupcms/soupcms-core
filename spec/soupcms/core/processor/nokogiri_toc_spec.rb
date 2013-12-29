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
        'label' => 'Header 1 1', 'href' => '#header-1-1', 'tag' => 'h2',
        'children' => [
          { 'label' => 'Header 1 1 1', 'href' => '#header-1-1-1', 'tag' => 'h3', 'children' => [] },
          { 'label' => 'Header 1 1 2', 'href' => '#header-1-1-2', 'tag' => 'h3', 'children' => [] }
        ]
      },
      {
        'label' => 'Header 1 2', 'href' => '#header-1-2', 'tag' => 'h2',
        'children' => [
          { 'label' => 'Header 1 2 1', 'href' => '#header-1-2-1', 'tag' => 'h3', 'children' => [] }
        ]
      }
    ]
    page_module = SoupCMS::Core::Model::PageModule.new({},nil)
    page_module.data['sidebar-document'] = { 'content' => { 'value' => html} }
    recipe_hash = {
        'type' => 'post-processor',
        'processor' => 'SopuCMS::Core::Processor::NokogiriToc',
        'config' => {
          'toc_for' => "\#{data['sidebar-document']['content']['value']}"
        },
        'return' => 'sidebar-document'
    }
    toc = SoupCMS::Core::Processor::NokogiriTOC.new(recipe_hash,page_module).execute
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
          'label' => 'Header 1', 'href' => '#header-1', 'tag' => 'h1',
          'children' => [
              {
                  'label' => 'Header 1 1', 'href' => '#header-1-1', 'tag' => 'h2',
                  'children' => [
                      { 'label' => 'Header 1 1 1', 'href' => '#header-1-1-1', 'tag' => 'h3', 'children' => [] },
                      { 'label' => 'Header 1 1 2', 'href' => '#header-1-1-2', 'tag' => 'h3', 'children' => [] }
                  ]
              },
              {
                  'label' => 'Header 1 2', 'href' => '#header-1-2', 'tag' => 'h2',
                  'children' => [
                      { 'label' => 'Header 1 2 1', 'href' => '#header-1-2-1', 'tag' => 'h3', 'children' => [] }
                  ]
              }
          ]
      }
    ]
    page_module = SoupCMS::Core::Model::PageModule.new({},nil)
    page_module.data['sidebar-document'] = { 'content' => { 'value' => html} }
    recipe_hash = {
        'type' => 'post-processor',
        'processor' => 'SopuCMS::Core::Processor::NokogiriToc',
        'config' => {
            'toc_for' => "\#{data['sidebar-document']['content']['value']}"
        },
        'return' => 'sidebar-document'
    }
    toc = SoupCMS::Core::Processor::NokogiriTOC.new(recipe_hash,page_module).execute
    expect(toc).to eq(expected)
  end

  it 'h1 to h3 and missing h2' do
    html = <<-html
      <h1 id="header-1">Header 1</h1>
      <p>Here's a paragraph</p>

      <h3 id="header-1-1-1">Header 1 1 1</h3>
      <p>Here's a paragraph</p>

      <h3 id="header-1-1-2">Header 1 1 2</h3>
      <p>Here's a paragraph</p>

      <h3 id="header-1-1-3">Header 1 1 3</h3>
      <p>Here's a paragraph</p>

      <h2 id="header-1-2">Header 1 2</h2>
      <p>Here's a paragraph</p>

      <h3 id="header-1-2-1">Header 1 2 1</h3>
      <p>Here's a paragraph</p>
    html
    expected = [
      {
          'label' => 'Header 1', 'href' => '#header-1', 'tag' => 'h1',
          'children' => [
              { 'label' => 'Header 1 1 1', 'href' => '#header-1-1-1', 'tag' => 'h3', 'children' => [] },
              { 'label' => 'Header 1 1 2', 'href' => '#header-1-1-2', 'tag' => 'h3', 'children' => [] },
              { 'label' => 'Header 1 1 3', 'href' => '#header-1-1-3', 'tag' => 'h3', 'children' => [] },
              {
                  'label' => 'Header 1 2', 'href' => '#header-1-2', 'tag' => 'h2',
                  'children' => [
                      { 'label' => 'Header 1 2 1', 'href' => '#header-1-2-1', 'tag' => 'h3', 'children' => [] }
                  ]
              }
          ]
      }
    ]
    page_module = SoupCMS::Core::Model::PageModule.new({},nil)
    page_module.data['sidebar-document'] = { 'content' => { 'value' => html} }
    recipe_hash = {
        'type' => 'post-processor',
        'processor' => 'SopuCMS::Core::Processor::NokogiriToc',
        'config' => {
            'toc_for' => "\#{data['sidebar-document']['content']['value']}"
        },
        'return' => 'sidebar-document'
    }
    toc = SoupCMS::Core::Processor::NokogiriTOC.new(recipe_hash,page_module).execute
    expect(toc).to eq(expected)
  end


end