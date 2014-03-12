Feature: Manage scholarship teams
  In order to categorize projects
  An master
  wants to manage scholarship teams
  
  Background:
  
    Given a user named "user"
    And I log in as "user"

  Scenario: Create scholarship team
    When I go to the new scholarship team page
    And I choose "scholarship_team_kind_sponsored"
    And I fill in "Name" with "scholarship team 1"
    And I press "Create Scholarship Team"
    Then I should see "Creation successful"
    And I should see "Destroy"
    And I should see "scholarship team 1"

  Scenario: Edit scholarship team
    Given a scholarship team named "scholarship team 1" with me as leader
    When I go to the edit scholarship team page
    And I fill in "Name" with "scholarship team 2"
    And I press "Update Scholarship Team"
    Then I should see "Update successful"
    And I should see "Destroy"
    And I should see "scholarship team 2"
    
  @javascript
  Scenario: Delete scholarship team
    Given 2 scholarship teams with me as leader
    When I delete the 1st "scholarship_team"
    Then I should see "Resource destroyed successfully"
    Then I should see the following table:
      |Name | |
      |scholarship team 2 | Actions | 
      
  Scenario: Cannot delete scholarship team which is not assigned to my oranization
    Given a scholarship team named "scholarship team 1"
    And I am on the scholarship teams page
    Then I should not see "Destroy"