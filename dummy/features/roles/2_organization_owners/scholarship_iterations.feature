Feature: Manage scholarship iterations
  In order to categorize projects
  An master
  wants to manage scholarship iterations
  
  Background:
  
    Given a user named "user"
    And I log in as "user"

  Scenario: Create scholarship iteration
    Given an organization named "organization 1" assigned to me
    And a scholarship program named "scholarship program 1" assigned to my organization
    When I go to the new scholarship iteration page
    And I fill in "Name" with "scholarship iteration 1"
    And I fill in "From" with "2014-06-01"
    And I fill in "To" with "2014-09-01"
    And I press "Create Scholarship Iteration"
    Then I should see "Creation successful"
    And I should see "Destroy"
    And I should see "scholarship iteration 1"

  Scenario: Edit scholarship iteration
    Given an organization named "organization 1" assigned to me
    And a scholarship program named "scholarship program 1" assigned to my organization
    And a scholarship iteration named "scholarship iteration 1" assigned to my scholarship program
    When I go to the edit scholarship iteration page
    And I fill in "Name" with "scholarship iteration 2"
    And I press "Update Scholarship Iteration"
    Then I should see "Update successful"
    And I should see "Destroy"
    And I should see "scholarship iteration 2"
    
  @javascript
  Scenario: Delete scholarship iteration
    Given an organization named "organization 1" assigned to me
    And a scholarship program named "scholarship program 1" assigned to my organization
    And 2 scholarship iterations assigned to my scholarship program
    When I delete the 1st "scholarship_iteration"
    Then I should see "Resource destroyed successfully"
    Then I should see the following table:
      |Name | |
      |scholarship iteration 2 | Actions | 
      
  Scenario: Cannot delete scholarship iteration which is not assigned to my oranization
    Given a scholarship iteration named "scholarship iteration 1"
    And I am on the scholarship iterations page
    Then I should not see "Destroy"