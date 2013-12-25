module SoupCMS
  module Core
    module Template


      class TemplateFileStore

        def initialize(file_path)
          @file_path = file_path
          SoupCMSCore.config.sprockets.append_path(file_path) if SoupCMSCore.config.sprockets
        end

        def find(context, template_path, type, kind = nil)
          template_path = build_path(template_path,kind) if kind
          file = File.join(@file_path, "#{template_path}.#{type}")
          File.read(file) if File.exist?(file)
        end

        private
        def build_path(template_name, kind)
          File.join(kind, template_name, template_name.split('/').last)
        end

      end


    end
  end
end