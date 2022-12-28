When /^a GET request is sent to "(.*?)"$/ do |url|
  visit url
end

When /^I go to "([^"]*)"$/ do |page_name|
  visit path_to(page_name)
end

When /^I wait for "([^"]*)" seconds$/ do |sec|
  sleep sec.to_I
end
