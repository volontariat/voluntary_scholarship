Feature: Read scholarship team memberships
  In order to describe scholarship team memberships
  A guest
  Wants to try to add an scholarship team membership
  
  Scenario: Cannot join teams
    Given a scholarship team named "Team 1"
    When I go to the new scholarship team membership page
    Then I should not see "Join Team"