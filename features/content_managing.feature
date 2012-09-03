Feature: Moderator Access
  As moderator user
  I can access to  management system
  so I can manage system

  Background:
    Given moderator user
    #And moderator user
    #And regular user
    #

  Scenario: Admin can access admin section
    Given I sign in as moderator
    When I go to admin section
    Then I should not see links to manage users
    Then I should see links to manage pages
    And I should see links to manage news
    And I should see links to manage page parts
    And I should see links to view feedback
    And I should see links to track site activities

