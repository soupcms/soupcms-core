module SoupCMS
  module Core
    module Utils


      class ParamsHash < Hash

        def to_query
          build_nested_query(self)
        end

        private

        def build_nested_query(value, prefix = nil)
          case value
            when Array
              value.map { |v| build_nested_query(v, "#{prefix}%5B%5D") }.join("&")
            when Hash
              value.map { |k, v|
                build_nested_query(v, prefix ? "#{prefix}%5B#{escape(k)}%5D" : escape(k))
              }.join("&")
            when NilClass
              prefix
            else
              raise ArgumentError, "value must be a Hash" if prefix.nil?
              "#{prefix}=#{escape(value)}"
          end
        end

        ESCAPE_RE = /[^a-zA-Z0-9 .~_-]/

        def escape(s)
          s.to_s.gsub(ESCAPE_RE) {|match|
            '%' + match.unpack('H2' * match.bytesize).join('%').upcase
          }.tr(' ', '+')
        end

      end



    end
  end
end
