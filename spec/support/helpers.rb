module Helpers

  def html_response
    Nokogiri::HTML(last_response.body)
  end

  def html(html_as_string)
    Nokogiri::HTML(html_as_string)
  end

  def read_file(file_name)
    File.read("spec/fixtures/#{file_name}.json")
  end

  def read_json(file_name)
    JSON.parse(read_file(file_name))
  end

  def read_files(*file_names)
    file_names.collect { |file| read_json(file) }.to_json
  end
end