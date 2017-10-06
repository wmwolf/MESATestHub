Feature: Check Test Overview

  Background: test cases have been added to the database
    Given the following test cases have been created:
      | name             | last_tested  | last_version_status | last_version |
      | 1M_pre_ms_to_wd  | '2017-10-04 03:34:23 UTC' | 0      | 10000        |
      | 15M_thermohaline | '2017-10-05 10:30:14 UTC' | 1      | 10000        |
      | wd2              | '2017-09-15 22:23:03 UTC' | 2      | 10000        |
      | wd_ignite        | '2017-09-28 20:34:11 UTC' | 2      | 9795         |

    Then 4 seed test cases should exist


  Scenario: User welcomed to homepage
    Given I am on the home page
    Then I should see "Welcome to MESA Test Hub!"

  Scenario: Existing test cases are visible
    Given I am on the home page
    Then I should see "1M_pre_ms_to_wd"
    And I should see "wd_ignite"

  Scenario: Passing tests are green
    Given I am on the home page
    Then the "1M_pre_ms_to_wd" row should be green

  Scenario: Failing tests are red
    Given I am on the home page
    Then the "15M_thermohaline" row should be red

  Scenario: Mixed results test are yellow
    Given I am on the home page
    Then the "wd2" row should be yellow

  Scenario: Add a new test case
    Given I am on the home page
    Then I should see "Create Test Case"
    When I follow "Create Test Case"
    Then I should be on the new test case page

  # This doesn't seem to work since it depends on javascript working
  # perhaps test in jade later?
  # Scenario: Table rows take user to test details
  #   Given I am on the home page
  #   And I click on the "#1M_pre_ms_to_wd" row
  #   Then I should be on the test detail page for "1M_pre_ms_to_wd"