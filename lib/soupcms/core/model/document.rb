module SoupCMS
  module Core
    module Model


      class Document

        def initialize doc
          @document = doc
        end

        def [](key)
          @document[key]
        end

        def to_hash
          @document
        end

        def publish_datetime
          Time.at(@document['publish_datetime'])
        end

      end


    end
  end
end