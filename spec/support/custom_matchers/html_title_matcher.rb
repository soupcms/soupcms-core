require 'rspec/expectations'

RSpec::Matchers.define :have_title do |expected|
  match do |actual|
    actual.css('title').text == expected
  end
  failure_message_for_should do |actual|
    "could not find: \"#{expected}\" in: \n #{actual.to_html}"
  end
end
