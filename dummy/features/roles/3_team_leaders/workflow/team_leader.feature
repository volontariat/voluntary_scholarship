@javascript
Feature: Manage transitions of scholarship team memberships

  In order to handle a scholarship team membership's different states
  A team leader
  Wants to do transitions
 
  Background:
  
    Given a user named "user"
    And a scholarship team named "scholarship team 1" with me as leader
    And I log in as "user" 
  
  Scenario: Accept scholarship team membership request
    Given a requested scholarship team membership for my team
    When I go to the scholarship workflow page for team leader
    And follow "Actions"
    And follow "Accept"
    Then I should see "Update successful"
    
  Scenario: Deny scholarship team membership request
    Given a requested scholarship team membership for my team
    When I go to the scholarship workflow page for team leader
    And follow "Actions"
    And follow "Deny"
    Then I should see "Update successful"    