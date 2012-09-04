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

  @pages
  Scenario: Content manager can manage static pages
    Given I sign in as regular user
    When I go to static pages management page
    #Then I should see list of static pages
    Then I should see only admin notification

  @news
  Scenario: Content manager can manage news
    Given I sign in as regular user
    When I go to news management page
    Then I should see only admin notification

  @users
  Scenario: Content manager can not manage users
    Given I sign in as regular user
    When I go to users management page
    Then I should see only admin notification

  @page_parts
  Scenario: Content manager can manage page parts
    Given I sign in as regular user
    When I go to static page parts
    #Then I should see list of page parts
    Then I should see only admin notification

  @feedbacks
  Scenario: Content manager can browse feedbacks
    Given I sign in as regular user
    When I go to feedabacks page
    Then I should see only admin notification

  @activities
  Scenario: Admin track user activities
    Given I sign in as regular user
    When I go to activities list
    Then I should see only admin notification


