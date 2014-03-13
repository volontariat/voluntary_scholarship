Feature: Manage scholarship team memberships
  In order to categorize projects
  An master
  wants to manage scholarship team memberships
  
  Background:
  
    Given a user named "user"
    And I log in as "user"

  Scenario: Join Team
    Given a scholarship team named "Team 1"
    When I go to the new scholarship team membership page
    And I check "scholarship_team_membership_roles_student"
    And I press "Create Scholarship Team Membership"
    Then I should see "Creation successful"
    And I should see "Leave Team"

  Scenario: Edit scholarship team membership
    Given a scholarship team membership for me
    When I go to the edit scholarship team membership page
    And I fill in "Text" with "Dummy"
    And I press "Update Scholarship Team Membership"
    Then I should see "Update successful"
    
  @javascript
  Scenario: Leave Team
    Given a scholarship team membership for me
    When I go to the scholarship team memberships page
    And I follow "Leave Team"
    Then I should see "Resource destroyed successfully"