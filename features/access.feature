Feature: Administartion
  As admin user
  I can acces to site management system
  so I can manage system

  Background:
    Given admin user
    #And moderator user
    #And regular user
    #

  Scenario: Admin can access admin section
    Given I sign in as admin
    When I go to admin section
    Then I should see links to manage users
    Then I should see links to manage pages
    And I should see links to manage news
    And I should see links to manage page parts
    And I should see links to view feedback
    And I should see links to track site activities

