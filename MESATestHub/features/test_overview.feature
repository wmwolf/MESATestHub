Feature: Check Test Overview

  Background: test cases have been added to the database
    Given the following test cases have been created:
      | name             |
      | 1M_pre_ms_to_wd  |
      | 15M_thermohaline |
      | wd2              |
      | wd_ignite        |

    Then 4 seed test cases should exist

    Given the following computers have been created:
      | name  |
      | compy |

    And 1 seed computer should exist

    Given the following test instances have been created:
      | test_case        | computer | passed | mesa_version | runtime_seconds |
      | 1M_pre_ms_to_wd  | compy    | true   | 10000        | 5000            |
      | 15M_thermohaline | compy    | true   | 10000        | 5000            |
      | 15M_thermohaline | compy    | false  | 10000        | 5000            |
      | wd2              | compy    | true   | 10000        | 5000            |
      | wd2              | compy    | false  | 9795         | 5000            |
      | wd_ignite        | compy    | false  | 10000        | 5000            |



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
    And the "wd2" row should be green

  Scenario: Failing tests are red
    Given I am on the home page
    Then the "wd_ignite" row should be red

  Scenario: Mixed results test are yellow
    Given I am on the home page
    Then the "15M_thermohaline" row should be yellow

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