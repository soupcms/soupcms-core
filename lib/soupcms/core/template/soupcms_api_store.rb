module SoupCMS
  module Core
    module Template


      class SoupCMSApiStore

        def soupcms_api(context)
          @soupcms_api ||= SoupCMS::Core::Api::Service.new(context.application, context.drafts?)
        end

        def find_template(context, template_path, type, kind = nil)
          documents = soupcms_api(context).find('templates', build_filters(kind, template_path, type))
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