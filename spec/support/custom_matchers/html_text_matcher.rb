require 'rspec/expectations'

RSpec::Matchers.define :have_text do |css_matcher,expected,index|
  match do |actual|
    if index.nil?
      actual.css(css_matcher).text.strip == expected
    else
      actual.css(css_matcher)[index].text.strip == expected
    end
  end
  failure_message do |actual|
    if index.nil?
      "  actual: #{actual.css(css_matcher).text}" + "\n" +
      "expected: #{expected}" + "\n" +
      '      in: ' + "\n" +
      "#{actual.to_html}"
    else
      "  actual: #{actual.css(css_matcher)[index].text}" + "\n" +
      "expected: #{expected}" + "\n" +
      '      in: ' + "\n" +
      "#{actual.to_html}"
    end
  end
end
