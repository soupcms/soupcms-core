require 'nokogiri'

module SoupCMS
  module Core
    module Processor

      class NokogiriTOC

        def initialize(html)
          @html = html
        end

        def build_toc
          doc = Nokogiri::HTML(@html)
          headers = doc.xpath('//h1 | //h2 | //h3 | //h4 | //h5 | //h6')
          toc = []
          top_level = 0
          headers.each do |header|
            node = {'label' => header.text.chomp.strip, 'href' => "\##{header['id']}", 'children' => []}
            if toc.empty?
              toc.push(node)
              top_level = header.name[1].to_i
            else
              current_level = header.name[1].to_i
              if current_level == top_level
                toc.push(node)
              elsif current_level == top_level + 1
                toc.last['children'].push(node)
              elsif current_level == top_level + 2
                toc.last['children'].last['children'].push(node)
              elsif current_level == top_level + 3
                toc.last['children'].last['children'].last['children'].push(node)
              elsif current_level == top_level + 4
                toc.last['children'].last['children'].last['children'].last['children'].push(node)
              elsif current_level == top_level + 5
                toc.last['children'].last['children'].last['children'].last['children'].last['children'].push(node)
              end
            end
          end
          toc
        end

      end

    end
  end
end
