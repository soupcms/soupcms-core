module Helpers

  def html_response
    Nokogiri::HTML(last_response.body)
  end
end