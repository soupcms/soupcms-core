require 'rspec/expectations'

RSpec::Matchers.define :have_title do |expected|
  match do |actual|
    actual.css('title').text.strip == expected
  end
  failure_message do |actual|
    "  actual: #{actual.css('title').text}" + "\n" +
    "expected: #{expected}" + "\n" +
    '      in: ' + "\n" +
    "#{actual.to_html}"
  end
end
