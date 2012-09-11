@restricted_access
Feature: restricted access
  As guest user
  I can not acces admin and dashboard section of site
  so I could not do any harm

  Scenario: can not access personal page
    When I go to personal page
    Then I should not see link to profile page

  Scenario: can not access admin section
    When I go to admin section
    Then I should not see links to manage users
    And I should not see links to manage pages
    And I should not see links to manage news
    And I should not see links to manage page parts
    And I should not see links to view feedback
    And I should not see links to track site activities
