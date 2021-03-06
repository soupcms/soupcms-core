module SoupCMS
  module Core
    module Template


      class FileStore

        def initialize(file_path)
          @file_path = file_path
        end

        def find_template(context, template_path, type, kind = nil)
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