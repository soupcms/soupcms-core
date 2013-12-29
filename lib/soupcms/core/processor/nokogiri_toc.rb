require 'nokogiri'

module SoupCMS
  module Core
    module Processor

      class NokogiriTOC

        def initialize(recipe_hash, page_module)
          @recipe_hash = recipe_hash
          @page_module = page_module
        end

        def execute
          html_content = @page_module.instance_eval("\"#{@recipe_hash['config']['toc_for']}\"")
          build_toc html_content
        end

        def build_toc(html_content)
          doc = Nokogiri::HTML(html_content)
          levels = @recipe_hash['config']['levels'] || %w(h1 h2 h3 h4 h5 h6)
          xpath = levels.collect { |l| "//#{l}[@id]" }.join(' | ')
          headers = doc.xpath(xpath)
          toc = []
          top_level = 0
          headers.each do |header|
            node = {'label' => header.text.chomp.strip, 'href' => "\##{header['id']}", 'tag' => header.name, 'children' => []}
            if toc.empty?
              toc.push(node)
              top_level = header.name[1].to_i
            else
              current_level = header.name[1].to_i
              if current_level <= top_level
                toc.push(node)
              else
                get_toc_level_last_node(toc, current_level-top_level, header.name).push(node)
              end
            end
          end
          toc
        end

        def get_toc_level_last_node(toc, level, current_tag)
          return toc.last['children'] if level == 1 || toc.last['children'].last.nil? || toc.last['children'].last['tag'] == current_tag
          get_toc_level_last_node(toc.last['children'], level-1, current_tag)
        end

      end

    end
  end
end
