@sign_in
Feature: Sign in
  As regular user
  I can sign in
  so I ca acces my personal page

  Background:
    Given regular user

  Scenario: regular user can access personal page
    Given I sign in as regular user
    When I go to personal page
    #Then I should see link to reports page
    #And I should see link to payments page
    Then I should see link to profile page

  Scenario: regular user can not access admin section
    Given I sign in as regular user
    When I go to admin section
    Then I should not see links to manage users
    And I should not see links to manage pages
    And I should not see links to manage news
    And I should not see links to manage page parts
    And I should not see links to view feedback
    And I should not see links to track site activities

  @pages
  Scenario: Regular user can not manage static pages
    Given I sign in as regular user
    When I go to static pages management page
    #Then I should see list of static pages
    Then I should see no access notification

  @news
  Scenario: Regular user can not manage news
    Given I sign in as regular user
    When I go to news management page
    Then I should see no access notification

  @users
  Scenario: Regular user manager can not manage users
    Given I sign in as regular user
    When I go to users management page
    Then I should see no access notification

  @page_parts
  Scenario: Regular user can manage page parts
    Given I sign in as regular user
    When I go to static page parts
    #Then I should see list of page parts
    Then I should see no access notification

  @feedbacks
  Scenario: Regular user can not browse feedbacks
    Given I sign in as regular user
    When I go to feedabacks page
    Then I should see no access notification

  @activities
  Scenario: Regular user can not track user activities
    Given I sign in as regular user
    When I go to activities list
    Then I should see no access notification


