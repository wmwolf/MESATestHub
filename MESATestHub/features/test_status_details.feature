Feature: View Test Status Details
  Background: three tests and several test instances are created
    Given the following test cases have been created:
      | name             |
      | 1M_pre_ms_to_wd  |
      | 15M_thermohaline |
      | wd2              |
      | wd_ignite        |
    And the following computers have been created:
      | name  | user         |
      | compy | Bill Paxton  |
      | lappy | Frank Timmes |
    And the following test instances have been created:
      | runtime_seconds | mesa_version | passed | test_name        | computer_name |
      | 1500            | 10000        | true   | 1M_pre_ms_to_wd  | compy         |
      | 3300            | 10000        | true   | 1M_pre_ms_to_wd  | lappy         |
      | 10              | 10000        | false  | 15M_thermohaline | compy         |
      | 1900            | 9597         | true   | 15M_thermohaline | compy         |
    Then 4 seed test cases should exist
    And 2 seed computers should exist
    And 4 seed test instances should exist

  Scenario: Test case name is on its page
    Given I am on the test detail page for "1M_pre_ms_to_wd"
    Then I should see "1M_pre_ms_to_wd"

  Scenario: Testing computers should be on page
    Given I am on the test detail page for "1M_pre_ms_to_wd"
    Then I should see "compy"
    And I should see "lappy"

  Scenario: Computers that didn't test should not be on page
    Given I am on the test detail page for "15M_thermohaline"
    Then I should see "compy"
    But I should not see "lappy"
