module SoupCMS
  module Core
    module Utils


      class ParamsHash < Hash


        def to_query_params
          params = ''
          stack = []

          each do |k, v|
            if v.is_a?(Hash)
              stack << [k,v]
            elsif v.is_a?(Array)
              stack << [k,Hash.from_array(v)]
            else
              params << "#{k}=#{v}&"
            end
          end

          stack.each do |parent, hash|
            hash.each do |k, v|
              if v.is_a?(Hash)
                stack << ["#{parent}[#{k}]", v]
              else
                params << "#{parent}[]=#{v}&"
              end
            end
          end

          params.chop!
          params
        end

        def self.from_array(array = [])
          h = Hash.new
          array.size.times do |t|
            h[t] = array[t]
          end
          h
        end

      end


    end
  end
end
