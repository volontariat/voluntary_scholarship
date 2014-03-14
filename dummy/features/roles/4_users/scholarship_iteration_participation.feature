Feature: Manage scholarship iteration participations
  In order to categorize projects
  An master
  wants to manage scholarship iteration participations
  
  Background:
  
    Given a user named "user"
    And I log in as "user"

  Scenario: Join Iteration
    Given a scholarship team named "scholarship team 1"
    And an accepted scholarship team membership for me and my team
    And a scholarship iteration named "scholarship iteration 1"
    When I go to the new scholarship iteration participation page
    And I select "scholarship team 1" from "Team"
    And I check "scholarship_iteration_participation_roles_student"
    And I press "Create Scholarship Iteration Participation"
    Then I should see "Creation successful"
    And I should see "Leave Iteration"

  Scenario: Edit scholarship iteration participation
    Given a scholarship iteration participation for me
    When I go to the edit scholarship iteration participation page
    And I fill in "Text" with "Dummy"
    And I press "Update Scholarship Iteration Participation"
    Then I should see "Update successful"
    
  @javascript
  Scenario: Leave Iteration
    Given a scholarship iteration participation for me
    When I go to the scholarship iteration participations page
    And I follow "Leave Iteration"
    Then I should see "Resource destroyed successfully"