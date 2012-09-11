@administration
Feature: Administartion
  As admin user
  I can acces to site management system
  so I can manage system

  Background:
    Given admin user
    And static page "help"
    And static page "about"
    And news entry "Event 1"
    And news entry "Event 2"
    And feedback with message "I love this site"
    And page part "NEW_CONTACTS_PAGE"
    And user activity "some activity"
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

  Scenario: Admin can manage forum
    Given I sign in as admin
    When I go to forum admin section
    Then I should see link to manage forum sections
    And I should see link to manage categories
    And I should see link to manage forum users
  
  @pages
  Scenario: Admin can manage static pages
    Given I sign in as admin
    When I go to static pages management page
    Then I should see list of static pages
  @news
  Scenario: Admin can manage news
    Given I sign in as admin
    When I go to news management page
    Then I should see list of news

  @users
  Scenario: Admin can manage users
    Given I sign in as admin
    When I go to users management page
    Then I should see list of users

  @page_parts
  Scenario: Admin can manage page parts
    Given I sign in as admin
    When I go to static page parts
    Then I should see list of page parts

  @feedbacks
  Scenario: Admin can browse feedbacks
    Given I sign in as admin
    When I go to feedabacks page
    Then I should see list of feedbacks

  @activities
  Scenario: Admin track user activities
    Given I sign in as admin
    When I go to activities list
    Then I should see list of activities


