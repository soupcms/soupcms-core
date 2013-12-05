require 'rspec/expectations'

RSpec::Matchers.define :have_text do |css_matcher,expected,index|
  match do |actual|
    if index.nil?
      actual.css(css_matcher).text == expected
    else
      actual.css(css_matcher)[index].text == expected
    end
  end
  failure_message_for_should do |actual|
    "could not find: \"#{expected}\" in: \n #{actual.to_html} \n actual: #{actual.css(css_matcher).text}"
  end
end
