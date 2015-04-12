@javascript
Feature: Manage transitions of scholarship iteration participations

  In order to handle a scholarship iteration participation's different states
  A organization owner
  Wants to do transitions
 
  Background:
  
    Given a user named "user"
    And a scholarship team named "scholarship team 1" with me as leader
    And I log in as "user" 
  
  Scenario: Accept scholarship iteration participation request
    Given a requested scholarship iteration participation for my iteration
    When I go to the scholarship workflow page for organization owner
    And follow "Actions"
    And follow "Accept"
    Then I should see "Update successful"
    
  Scenario: Deny scholarship iteration participation request
    Given a requested scholarship iteration participation for my iteration
    When I go to the scholarship workflow page for organization owner
    And follow "Actions"
    And follow "Deny"
    Then I should see "Update successful"    