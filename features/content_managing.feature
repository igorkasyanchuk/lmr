@moderation
Feature: Moderator Access
  As moderator user
  I can access to  management system
  so I can manage system

  Background:
    Given moderator user
    And news entry "Event 1"
    And news entry "Event 2"

  Scenario: Moderator can access admin section
    Given I sign in as moderator
    When I go to admin section
    Then I should not see links to manage users
    And I should see links to manage pages
    And I should see links to manage news
    And I should see links to manage page parts
    And I should see links to view feedback
    And I should see links to track site activities

  Scenario: Moderator can manage forum
    Given I sign in as moderator
    When I go to forum admin section
    Then I should see link to manage forum sections
    And I should see link to manage categories
    And I should see link to manage forum users

  @pages
  Scenario: Content manager can manage static pages
    Given I sign in as moderator
    When I go to static pages management page
    #Then I should see list of static pages
    Then I should see only admin notification

  @news
  Scenario: Content manager can manage news
    Given I sign in as moderator
    When I go to news management page
    Then I should see list of news

  @users
  Scenario: Content manager can not manage users
    Given I sign in as moderator
    When I go to users management page
    Then I should see only admin notification

  @page_parts
  Scenario: Content manager can manage page parts
    Given I sign in as moderator
    When I go to static page parts
    #Then I should see list of page parts
    Then I should see only admin notification

  @feedbacks
  Scenario: Content manager can browse feedbacks
    Given I sign in as moderator
    When I go to feedabacks page
    Then I should see only admin notification

  @activities
  Scenario: Admin track user activities
    Given I sign in as moderator
    When I go to activities list
    Then I should see only admin notification


