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
          headers = doc.xpath('//h1[@id] | //h2[@id] | //h3[@id] | //h4[@id] | //h5[@id] | //h6[@id]')
          toc = []
          top_level = 0
          headers.each do |header|
            node = {'label' => header.text.chomp.strip, 'href' => "\##{header['id']}", 'tag' => header.name , 'children' => []}
            if toc.empty?
              toc.push(node)
              top_level = header.name[1].to_i
            else
              current_level = header.name[1].to_i
              if current_level <= top_level
                toc.push(node)
              elsif current_level == top_level + 1
                get_toc_level_last_node(toc,1, header.name).push(node)
              elsif current_level == top_level + 2
                get_toc_level_last_node(toc,2, header.name).push(node)
              elsif current_level == top_level + 3
                get_toc_level_last_node(toc,3, header.name).push(node)
              elsif current_level == top_level + 4
                get_toc_level_last_node(toc,4, header.name).push(node)
              elsif current_level == top_level + 5
                get_toc_level_last_node(toc,5, header.name).push(node)
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
