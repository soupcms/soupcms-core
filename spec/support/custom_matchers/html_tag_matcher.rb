require 'rspec/expectations'

RSpec::Matchers.define :have_text do |css_matcher,expected|
  match do |actual|
    actual.css(css_matcher).text == expected
  end
  failure_message_for_should do |actual|
    "   ACTUAL: #{actual.css(css_matcher).text} \n EXPECTED: #{expected}"
  end
end
