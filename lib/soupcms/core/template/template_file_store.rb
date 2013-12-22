module SoupCMS
  module Core
    module Template


      class TemplateFileStore

        def initialize(file_path)
          @file_path = file_path
        end

        def find(kind, template_name, type)
          file = File.join(@file_path, kind, template_name, "#{template_name.split('/').last}.#{type}")
          File.read(file) if File.exist?(file)
        end

        def find_partial(template_path)
          file = File.join(@file_path, template_path)
          File.read(file) if File.exist?(file)
        end

      end


    end
  end
end