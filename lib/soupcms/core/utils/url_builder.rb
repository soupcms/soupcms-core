module SoupCMS
  module Core
    module Utils


      class UrlBuilder

        def self.build(model_name, filters)
          return model_name if filters.nil? || filters.empty?
          url = "#{model_name}?"
          filter_index = 0
          filters.each { |key, value|
            url.concat('&') if filter_index >= 1
            if value.kind_of?(String)
              url.concat("#{key}=\"#{value}\"")
            elsif value.kind_of?(Integer)
              url.concat("#{key}=#{value}")
            elsif value.kind_of?(Array)
              index = 0
              value.each do |val|
                url.concat('&') if index >= 1
                url.concat("#{key}[]=\"#{val}\"") if val.kind_of?(String)
                url.concat("#{key}[]=#{val}") if val.kind_of?(Integer)
                index += 1
              end
            end
            url.concat("&filters[]=#{key}") unless key == "tags" || key == :tags
            filter_index += 1
          }
          url
        end


      end


    end
  end
end