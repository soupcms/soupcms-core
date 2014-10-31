require 'rspec/expectations'

RSpec::Matchers.define :have_attribute do |css_matcher,attribute,expected|

  match do |actual|
    if expected.class == Regexp
      return expected.match(actual.xpath(css_matcher)[0][attribute]).length > 0 if expected.match(actual.xpath(css_matcher)[0][attribute])
    else
      return actual.xpath(css_matcher)[0][attribute].strip == expected
    end
    false
  end

  failure_message do |actual|
    "  actual: #{actual.xpath(css_matcher)[0][attribute]}" + "\n" +
    "expected: #{expected}" + "\n" +
    '      in: ' + "\n" +
    "#{actual.to_html}"
  end
end
