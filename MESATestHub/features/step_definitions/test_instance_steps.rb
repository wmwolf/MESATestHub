require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# populate table of test instances
Given /^the following test instances have been created:$/ do |fields|
  fields.hashes.each do |test|
    test_instance = TestInstance.new do |t|
      t.runtime_seconds = test[:runtime_seconds]
      t.mesa_version = test[:mesa_version]
      t.passed = test[:passed]
    end
    test_case = TestCase.where(name: test[:test_case]).first
    computer = Computer.where(name: test[:computer]).first
    computer.test_instances << test_instance
    test_case.test_instances << test_instance
    test_instance.save!
  end
end 

# check number of test instances
Then /^(.*) seed test instances? should exist/ do |n_test_cases|
  expect(TestInstance.count).to be n_test_cases.to_i
end