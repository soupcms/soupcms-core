require 'rspec/expectations'

RSpec::Matchers.define :have_attribute do |css_matcher,attribute,expected|
  match do |actual|
    actual.css(css_matcher)[0][attribute] == expected
  end
  failure_message_for_should do |actual|
    "could not find: \"#{expected}\" in: \n #{actual.to_html}"
  end
end
