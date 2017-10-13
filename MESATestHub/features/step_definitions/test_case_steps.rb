require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# populate table of test cases
Given /^the following test cases have been created:$/ do |fields|
  fields.hashes.each do |test|
    TestCase.create(test)
  end
end 

# double checking the table population step
Then /^(.*) seed test cases? should exist/ do |n_test_cases|
  expect(TestCase.count).to be n_test_cases.to_i
end

# checking pass/mix/fail colors
Then /^the "(.*)" row should be (.*)$/ do |test_name, color|
  color_class = case color
  when "green" then 'table-success'
  when "yellow" then 'table-warning'
  when "red" then 'table-danger'
  else
    raise("invalid color: #{color}. Must be 'red', 'yellow', or 'green'.")
  end
  within('table#test_summary') do
    expect(find('tr', text: test_name)['class']).to include color_class
  end
end

# clicking on a table row on the home page (probably)
When /^(?:|I )click on the "([^"]*)" row$/ do |test_case_name|
  id = test_case_name + '-row'
  find(id).click
  save_and_open_page
end