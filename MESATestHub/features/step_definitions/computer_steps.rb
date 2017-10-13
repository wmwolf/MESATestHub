require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# populate table of test instances
Given /^the following computers have been created:$/ do |fields|
  fields.hashes.each do |computer|
    Computer.create(computer)
  end
end 

# check number of computers
Then /^(.*) seed computers? should exist/ do |n_test_cases|
  expect(Computer.count).to be n_test_cases.to_i
end