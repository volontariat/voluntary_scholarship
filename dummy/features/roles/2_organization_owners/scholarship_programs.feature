Feature: Manage scholarship programs
  In order to categorize projects
  An master
  wants to manage scholarship programs
  
  Background:
  
    Given a user named "user"
    And I log in as "user"

  Scenario: Create scholarship program
    Given an organization named "organization 1" assigned to me
    When I go to the new scholarship program page
    And I select "organization 1" from "Organization"
    And I fill in "Name" with "scholarship program 1"
    And I press "Create Scholarship Program"
    Then I should see "Creation successful"
    And I should see "Destroy"
    And I should see "scholarship program 1"

  Scenario: Edit scholarship program
    Given an organization named "organization 1" assigned to me
    And a scholarship program named "scholarship program 1" assigned to my organization
    When I go to the edit scholarship program page
    And I fill in "Name" with "scholarship program 2"
    And I press "Update Scholarship Program"
    Then I should see "Update successful"
    And I should see "Destroy"
    And I should see "scholarship program 2"
    
  @javascript
  Scenario: Delete scholarship program
    Given an organization named "organization 1" assigned to me
    And 2 scholarship programs assigned to my organization
    When I delete the 1st "scholarship_program"
    Then I should see "Resource destroyed successfully"
    Then I should see the following table:
      |Name | |
      |scholarship program 2 | Actions | 
      
  Scenario: Cannot delete scholarship program which is not assigned to my oranization
    Given a scholarship program named "scholarship program 1"
    And I am on the scholarship programs page
    Then I should not see "Destroy"