@sign_in
Feature: Sign in
  As regular user
  I can sign in
  so I ca acces my personal page

  Background:
    Given regular user

  Scenario: can access personal page
    Given I sign in as regular user
    When I go to personal page
    #Then I should see link to reports page
    #And I should see link to payments page
    Then I should see link to profile page

  Scenario: can not access admin section
    Given I sign in as regular user
    When I go to admin section
    Then I should not see links to manage users
    And I should not see links to manage pages
    And I should not see links to manage news
    And I should not see links to manage page parts
    And I should not see links to view feedback
    And I should not see links to track site activities
