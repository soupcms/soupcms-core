require 'rspec/expectations'

RSpec::Matchers.define :have_node do |selector|
  match do |actual|
    !actual.css(selector).empty?
  end

  failure_message do |actual|
    "Node '#{selector}' is not present in \n #{actual.to_html}"
  end

  failure_message_when_negated do |actual|
    "Node '#{selector}' is present in \n #{actual.to_html}"
  end
end
