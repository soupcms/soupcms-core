module SoupCMS
  module Core
    module Template


      class SoupCMSApiStore

        def find(context, template_path, type, kind = nil)
          documents = context.soupcms_api.find('templates', build_filters(kind, template_path, type))
          return documents[0]['template'] if documents[0]
        end

        def build_filters(kind, template_path, type)
          kind.nil? ?
              {'template_name' => template_path, 'type' => type} :
              {'kind' => kind, 'template_name' => template_path, 'type' => type}
        end


      end


    end
  end
end