require 'rspec/expectations'

RSpec::Matchers.define :have_title do |expected|
  match do |actual|
    actual.css('title').text == expected
  end
  failure_message_for_should do |actual|
    "   ACTUAL: #{actual.css('title').text} \n EXPECTED: #{expected}"
  end
end
