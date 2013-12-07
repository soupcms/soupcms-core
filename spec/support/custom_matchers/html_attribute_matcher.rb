require 'rspec/expectations'

RSpec::Matchers.define :have_attribute do |css_matcher,attribute,expected|
  match do |actual|
    actual.css(css_matcher)[0][attribute] == expected
  end
  failure_message_for_should do |actual|
    "  actual: #{actual.css(css_matcher)[0][attribute]}" + "\n" +
    "expected: #{expected}" + "\n" +
    '      in: ' + "\n" +
    "#{actual.to_html}"
  end
end