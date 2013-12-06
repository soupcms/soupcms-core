require 'rspec/expectations'

RSpec::Matchers.define :have_title do |expected|
  match do |actual|
    actual.css('title').text == expected
  end
  failure_message_for_should do |actual|
    "  actual: #{actual.css('title').text}" + "\n" +
    "expected: #{expected}" + "\n" +
    '      in: ' + "\n" +
    "#{actual.to_html}"
  end
end
